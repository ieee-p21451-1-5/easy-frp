# easy-frp

This repository is for easy deployment of [`frp`](https://github.com/fatedier/frp) in the IEEE P21451-1-5 demonstration system.

```shell
cd ~root/
git clone https://github.com/ieee-p21451-1-5/easy-frp.git
```

## On Cloud Server

```shell
vim ./easy-frp/frps.ini # and change the username & password for Dashboard 
cp ./easy-frp/systemd/frp-server.service /etc/systemd/system/
cp ./easy-frp/systemd/frps-traffic.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable frp-server.service frps-traffic.service
```

## On NCAP

### A Prerequisite

Since Raspberry Pi doesn't have any RTC, in its early stage of booting, the system time is "somewhen" on January 1, 1970. To avoid using such archaic (also incorrect, of course) timestamps in the naming of log files, we'd better start services after the system clock has been synchronized through Internet. We crafted a special service named `check-sync.service`, which will finish its initialization process only if the system clock has been synchronized. Having `check-sync.service`, we can make another service start with a correct system time, which is desired in a lot of cases. 

If you have set up the NCAP following the steps in [this page](https://github.com/ieee-p21451-1-5/demo-ncap),  `check-sync.service` should have already been installed.

### Deployment

```shell
vim ./easy-frp/frpc.ini # and change the IP address of cloud server
cp ./easy-frp/systemd/frp-client.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable frp-client.service 
```





