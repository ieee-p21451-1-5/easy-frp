#! /bin/bash

# This file should be put under /root/easy-frp/scripts/.

cd /root/easy-frp/
./bin/frps -c ./frps.ini > \
	./logs/frp-log-$(date +'%Y%m%d%H%M%S')
