#!/bin/sh
#This is an attempt to control the downlink datarate in real time using pfctl
#echo $$

#pfctl -F all -d; dnctl -q flush

echo "ok ok ok?"
#touch ./Tokenbin/token
./toggle_proxy.sh on

BANDWIDTH_1="5Mbit/s"
BANDWIDTH_2="4Mbit/s"
BANDWIDTH_3="3Mbit/s"
BANDWIDTH_4="2Mbit/s"
BANDWIDTH_5="1Mbit/s"
MAX_T=150

# Set a maximum limit
(sleep $MAX_T; pfctl -F all -d; dnctl -q flush; echo "Throttle removed\n"; ./toggle_proxy.sh off; pkill -2 -f 'python myproxy_csv.py';)&



# Starting BW
dnctl pipe 1 config bw $BANDWIDTH_1
echo "Speed set to: $BANDWIDTH_1\n"
echo "dummynet in from any to any pipe 1"|sudo pfctl -f -
pfctl -e

# Run a wireshark capture in parallel
#wireshark -i en0  -k -a duration:$MAX_T -w dumpcap


# Constricted BW
(sleep 30; dnctl pipe 1 config bw $BANDWIDTH_2; echo "Speed set to: $BANDWIDTH_2\n")&
# Constricted BW
(sleep 60; dnctl pipe 1 config bw $BANDWIDTH_3; echo "Speed set to: $BANDWIDTH_3\n")&
# Constricted BW
(sleep 90; dnctl pipe 1 config bw $BANDWIDTH_4; echo "Speed set to: $BANDWIDTH_4\n")&
# Constricted BW
(sleep 120; dnctl pipe 1 config bw $BANDWIDTH_5; echo "Speed set to: $BANDWIDTH_5\n")&

# Open a link and watch a video!
# open https://www.netflix.com/watch/70207872?trackId=14183197&tctx=0%2C1%2C850d8eec-40e2-40f1-a2e2-e4ab4f28a174-60747194%2C08875324-9854-46cd-83bf-c355d464f397_413280522X28X6839X1530121522002%2C08875324-9854-46cd-83bf-c355d464f397_ROOT

# Start proxy server
python myproxy_csv.py
# Clean up is set in motion on line 19

#echo "Proxy is letting me say this" 
