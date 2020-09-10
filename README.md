# easy-frp

This repository is for easy deployment of [`frp`](https://github.com/fatedier/frp) in the IEEE P21451-1-5 demonstration system.

```shell
cd ~root/
git clone https://github.com/ieee-p21451-1-5/easy-frp.git
```

## On Cloud Server

```shell
cp ./easy-frp/systemd/frp-server.service /etc/systemd/system/
cp ./easy-frp/systemd/frps-traffic.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable frp-server.service frps-traffic.service
```

## On NCAP

### A Prerequisite

Since Raspberry Pi doesn't have an RTC, in the its early stage of booting, Raspberry Pi's system time is "somewhen"  on Jan 1st, 1970. To avoid using such an archaic (also incorrect, of course) timestamp in the naming of log files, we'd better start services after the system clock has been synchronized through Internet. We crafted a special service named `check-sync.service`, which will finish its initialization process only if the system clock has been synchronized. Having `check-sync.service`, we can make another service start with a correct system time, which is desired in a lot of cases. 

If you have set up the NCAP following the steps in [this page](https://github.com/ieee-p21451-1-5/demo-ncap),  `check-sync.service` should have already been installed.

### Deployment

```shell
cp ./easy-frp/systemd/frp-client.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable frp-client.service 
```





