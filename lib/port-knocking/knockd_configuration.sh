#!/bin/bash

add_forward_knock() {

  KNOCK_NAME=$1
  OPEN_SEQUENCE=$2
  CLOSE_SEQUENCE=$3
  INPUT_INTERFACE=$4
  OUTPUT_INTERFACE=$5
  DESTINATION_IP=$6
  DESTINATION_PORT=$7
  
  COMMAND="/usr/local/sbin/pk_accept_forwarding $INPUT_INTERFACE $OUTPUT_INTERFACE %IP% $DESTINATION_IP $DESTINATION_PORT"

  echo "[open_$KNOCK_NAME]
    sequence    = $OPEN_SEQUENCE
    seq_timeout = 10
    tcpflags    = syn
    command     = $COMMAND" >> /etc/knockd.conf
    
  COMMAND="/usr/local/sbin/pk_delete_forwarding $INPUT_INTERFACE $OUTPUT_INTERFACE %IP% $DESTINATION_IP $DESTINATION_PORT"
    
  echo "[close_$KNOCK_NAME]
    sequence    = $CLOSE_SEQUENCE
    seq_timeout = 10
    tcpflags    = syn
    command     = $COMMAND" >> /etc/knockd.conf
}
    
add_input_knock() {

  KNOCK_NAME=$1
  OPEN_SEQUENCE=$2
  CLOSE_SEQUENCE=$3
  INPUT_INTERFACE=$4
  DESTINATION_PORT=$5
  
  COMMAND="/usr/local/sbin/accept_forward $INPUT_INTERFACE %IP% $DESTINATION_PORT"

  echo "[open_$KNOCK_NAME]
    sequence    = $OPEN_SEQUENCE
    seq_timeout = 10
    tcpflags    = syn
    command     = $COMMAND" >> /etc/knockd.conf
    
  COMMAND="/usr/local/sbin/delete_forward $INPUT_INTERFACE %IP% $DESTINATION_PORT"
    
  echo "[close_$KNOCK_NAME]
    sequence    = $CLOSE_SEQUENCE
    seq_timeout = 10
    tcpflags    = syn
    command     = $COMMAND" >> /etc/knockd.conf
}
