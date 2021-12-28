#!/bin/bash

create_iptables() {
  iptables -N ADLAMIN-INPUT
  iptables -N ADLAMIN-OUTPUT
  iptables -N ADLAMIN-FORWARD

  iptables -D INPUT -j ADLAMIN-INPUT
  iptables -A INPUT -j ADLAMIN-INPUT

  iptables -D OUTPUT -j ADLAMIN-OUTPUT
  iptables -A OUTPUT -j ADLAMIN-OUTPUT

  iptables -D FORWARD -j ADLAMIN-FORWARD
  iptables -A FORWARD -j ADLAMIN-FORWARD
}

enable_client(){
    # ARGS
    INTERFACE=$1
    PROTOCOL=$2
    PORT=$3

    iptables -I ADLAMIN-INPUT -i $INTERFACE -p $PROTOCOL --sport $PORT -m state --state ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-OUTPUT -o $INTERFACE -p $PROTOCOL --dport $PORT -m state --state NEW,ESTABLISHED -j ACCEPT
}

disable_client(){
    # ARGS
    INTERFACE=$1
    PROTOCOL=$2
    PORT=$3

    iptables -D ADLAMIN-INPUT -i $INTERFACE -p $PROTOCOL --sport $PORT -m state --state ESTABLISHED -j ACCEPT
    iptables -D ADLAMIN-OUTPUT -o $INTERFACE -p $PROTOCOL --dport $PORT -m state --state NEW,ESTABLISHED -j ACCEPT
}

enable_forward_client(){
    iptables -I ADLAMIN-FORWARD -i $1 -o $2 -p $3 --sport $4 -m state --state ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-FORWARD -o $1 -i $2 -p $3 --dport $4 -m state --state NEW,ESTABLISHED -j ACCEPT
}

disable_forward_client(){
    iptables -D ADLAMIN-FORWARD -i $1 -o $2 -p $3 --sport $4 -m state --state ESTABLISHED -j ACCEPT
    iptables -D ADLAMIN-FORWARD -o $1 -i $2 -p $3 --dport $4 -m state --state NEW,ESTABLISHED -j ACCEPT
}

delete_forward_to_server() {
    iptables -D ADLAMIN-FORWARD -i $1 -o $2 -s $3 -d $4 -p $5 --dport $6 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -D ADLAMIN-FORWARD -o $1 -i $2 -d $3 -s $4 -p $5 --sport $6 -m state --state ESTABLISHED -j ACCEPT
}

forward_to_server() {
    delete_forward_to_server $1 $2 $3 $4 $5 $6

    iptables -I ADLAMIN-FORWARD -i $1 -o $2 -s $3 -d $4 -p $5 --dport $6 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-FORWARD -o $1 -i $2 -d $3 -s $4 -p $5 --sport $6 -m state --state ESTABLISHED -j ACCEPT
}

delete_forward_to_server_from_any() {
    iptables -D ADLAMIN-FORWARD -i $1 -o $2 -d $3 -p $4 --dport $5 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -D ADLAMIN-FORWARD -o $1 -i $2 -s $3 -p $4 --sport $5 -m state --state ESTABLISHED -j ACCEPT
}

forward_to_server_from_any() {
    delete_forward_to_server_from_any $1 $2 $3 $4 $5

    iptables -I ADLAMIN-FORWARD -i $1 -o $2 -d $3 -p $4 --dport $5 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -I ADLAMIN-FORWARD -o $1 -i $2 -s $3 -p $4 --sport $5 -m state --state ESTABLISHED -j ACCEPT
}
