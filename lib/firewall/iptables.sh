#!/bin/bash

create_iptables() {

  iptables -F
  iptables -X
  iptables -Z

  create_chain ADLAMIN-INPUT
  create_chain ADLAMIN-OUTPUT
  create_chain ADLAMIN-FORWARD
  create_chain ADLAMIN-FORWARD_PK
  create_chain ADLAMIN-INPUT_FILTERS

  create_chain DOCKER
  create_chain DOCKER-ISOLATION-STAGE-1
  create_chain DOCKER-ISOLATION-STAGE-2
  create_chain DOCKER-ISOLATION-STAGE-3

  iptables -A INPUT -j ADLAMIN-INPUT

  iptables -A OUTPUT -j ADLAMIN-OUTPUT

  iptables -A FORWARD -j ADLAMIN-FORWARD

  iptables -A FORWARD -j ADLAMIN-FORWARD_PK
}

enable_client(){
    # ARGS
    INTERFACE=$1
    PROTOCOL=$2
    PORT=$3

    iptables -I ADLAMIN-INPUT -i $INTERFACE -p $PROTOCOL --sport $PORT -m state --state ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-OUTPUT -o $INTERFACE -p $PROTOCOL --dport $PORT -m state --state NEW,ESTABLISHED -j ACCEPT
}

enable_server_for(){
    # ARGS
    INTERFACE=$1
    PROTOCOL=$2
    PORT=$3
    CLIENT=$4

    iptables -I INPUT -i $INTERFACE -p $PROTOCOL --dport $PORT -m state --state NEW,ESTABLISHED -s $CLIENT -j  ACCEPT
    iptables -I OUTPUT -o $INTERFACE -p $PROTOCOL --sport $PORT -m state --state ESTABLISHED -d $CLIENT -j  ACCEPT
}

disable_client(){
    # ARGS
    INTERFACE=$1
    PROTOCOL=$2
    PORT=$3

    iptables -D ADLAMIN-INPUT -i $INTERFACE -p $PROTOCOL --sport $PORT -m state --state ESTABLISHED -j ACCEPT || true
    iptables -D ADLAMIN-OUTPUT -o $INTERFACE -p $PROTOCOL --dport $PORT -m state --state NEW,ESTABLISHED -j ACCEPT || true
}

enable_forward_client(){
    iptables -I ADLAMIN-FORWARD -i $1 -o $2 -p $3 --sport $4 -m state --state ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-FORWARD -o $1 -i $2 -p $3 --dport $4 -m state --state NEW,ESTABLISHED -j ACCEPT
}

disable_forward_client(){
    iptables -D ADLAMIN-FORWARD -i $1 -o $2 -p $3 --sport $4 -m state --state ESTABLISHED -j ACCEPT || true
    iptables -D ADLAMIN-FORWARD -o $1 -i $2 -p $3 --dport $4 -m state --state NEW,ESTABLISHED -j ACCEPT || true
}

delete_forward_to_server() {
    iptables -D ADLAMIN-FORWARD -i $1 -o $2 -s $3 -d $4 -p $5 --dport $6 -m state --state NEW,ESTABLISHED -j ACCEPT || true
    iptables -D ADLAMIN-FORWARD -o $1 -i $2 -d $3 -s $4 -p $5 --sport $6 -m state --state ESTABLISHED -j ACCEPT || true
}

forward_to_server() {
    delete_forward_to_server $1 $2 $3 $4 $5 $6

    iptables -I ADLAMIN-FORWARD -i $1 -o $2 -s $3 -d $4 -p $5 --dport $6 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-FORWARD -o $1 -i $2 -d $3 -s $4 -p $5 --sport $6 -m state --state ESTABLISHED -j ACCEPT
}

delete_forward_to_server_from_any() {
    iptables -D ADLAMIN-FORWARD -i $1 -o $2 -d $3 -p $4 --dport $5 -m state --state NEW,ESTABLISHED -j ACCEPT || true
    iptables -D ADLAMIN-FORWARD -o $1 -i $2 -s $3 -p $4 --sport $5 -m state --state ESTABLISHED -j ACCEPT || true
}

forward_to_server_from_any() {
    delete_forward_to_server_from_any $1 $2 $3 $4 $5

    iptables -I ADLAMIN-FORWARD -i $1 -o $2 -d $3 -p $4 --dport $5 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-FORWARD -o $1 -i $2 -s $3 -p $4 --sport $5 -m state --state ESTABLISHED -j ACCEPT
}

create_chain() {
  NAME=$1

  iptables -N $NAME
  iptables -F $NAME
  iptables -I $NAME -j RETURN
}

load_input_filters() {
  echo "TODO"
  iptables -I INPUT -j ADLAMIN-INPUT_FILTERS
}

drop_all() {
  iptables -P INPUT DROP
  iptables -P OUTPUT DROP
  iptables -P FORWARD DROP
}