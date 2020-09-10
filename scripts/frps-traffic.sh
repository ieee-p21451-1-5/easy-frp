#! /bin/bash

# This file should be put under /root/easy-frp/scripts/.

cd /root/easy-frp/
tcpdump -l -i any 'udp port 161' 2>&1 | \
	gawk -f ./scripts/tcpdump-output-process.awk > \
	./logs/frps-traffic-log-$(date +'%Y%m%d%H%M%S')
