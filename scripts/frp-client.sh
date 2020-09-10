#! /bin/bash

# This file should be put under /root/easy-frp/scripts/.

cd /root/easy-frp/
./bin/frpc -c ./frpc.ini > \
	./logs/frp-log-$(date +'%Y%m%d%H%M%S')
