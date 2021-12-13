#!/bin/bash

enable_client(){
    iptables -I INPUT -i eth0 -p $1 --sport $2 -m state --state ESTABLISHED -j ACCEPT
    iptables -I OUTPUT -o eth0 -p $1 --dport $2 -m state --state NEW,ESTABLISHED -j ACCEPT
}

disable_client(){
    iptables -D INPUT -i eth0 -p $1 --sport $2 -m state --state ESTABLISHED -j ACCEPT
    iptables -D OUTPUT -o eth0 -p $1 --dport $2 -m state --state NEW,ESTABLISHED -j ACCEPT
}

enable_forward_client(){
    iptables -I FORWARD -i $1 -o $2 -p $3 --sport $4 -m state --state ESTABLISHED -j ACCEPT
    iptables -I FORWARD -o $1 -i $2 -p $3 --dport $4 -m state --state NEW,ESTABLISHED -j ACCEPT
}

disable_forward_client(){
    iptables -D FORWARD -i $1 -o $2 -p $3 --sport $4 -m state --state ESTABLISHED -j ACCEPT
    iptables -D FORWARD -o $1 -i $2 -p $3 --dport $4 -m state --state NEW,ESTABLISHED -j ACCEPT
}

delete_forward_to_server() {
    iptables -D FORWARD -i $1 -o $2 -s $3 -d $4 -p $5 --dport $6 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -D FORWARD -o $1 -i $2 -d $3 -s $4 -p $5 --sport $6 -m state --state ESTABLISHED -j ACCEPT
}

forward_to_server() {
    delete_forward_to_server $1 $2 $3 $4 $5 $6

    iptables -I FORWARD -i $1 -o $2 -s $3 -d $4 -p $5 --dport $6 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -I FORWARD -o $1 -i $2 -d $3 -s $4 -p $5 --sport $6 -m state --state ESTABLISHED -j ACCEPT
}

delete_forward_to_server_from_any() {
    iptables -D FORWARD -i $1 -o $2 -d $3 -p $4 --dport $5 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -D FORWARD -o $1 -i $2 -s $3 -p $4 --sport $5 -m state --state ESTABLISHED -j ACCEPT
}

forward_to_server_from_any() {
    delete_forward_to_server_from_any $1 $2 $3 $4 $5

    iptables -I FORWARD -i $1 -o $2 -d $3 -p $4 --dport $5 -m state --state NEW,ESTABLISHED -j ACCEPT
    iptables -I FORWARD -o $1 -i $2 -s $3 -p $4 --sport $5 -m state --state ESTABLISHED -j ACCEPT
}
