#!/bin/sh
#This is an attempt to control the downlink datarate in real time using pfctl

BANDWIDTH_1="5Mbit/s"
BANDWIDTH_2="4Mbit/s"
BANDWIDTH_3="3Mbit/s"
BANDWIDTH_4="2Mbit/s"
BANDWIDTH_5="1Mbit/s"

# Starting BW
dnctl pipe 1 config bw $BANDWIDTH_1
echo "Speed set to: $BANDWIDTH_1\n"
echo "dummynet in from any to any pipe 1"|sudo pfctl -f -
pfctl -e


# Constricted BW
(sleep 60; dnctl pipe 1 config bw $BANDWIDTH_2; echo "Speed set to: $BANDWIDTH_2\n")&

# echo "dummynet in from any to any pipe 1"|sudo pfctl -f -
# Constricted BW
(sleep 120; dnctl pipe 1 config bw $BANDWIDTH_3; echo "Speed set to: $BANDWIDTH_3\n")&

# Constricted BW
(sleep 180; dnctl pipe 1 config bw $BANDWIDTH_4; echo "Speed set to: $BANDWIDTH_4\n")&

# Constricted BW
(sleep 240; dnctl pipe 1 config bw $BANDWIDTH_5; echo "Speed set to: $BANDWIDTH_5\n")&


# Clean up
(sleep 300; pfctl -F all -d; sudo dnctl -q flush; echo "Throttle removed\n")&