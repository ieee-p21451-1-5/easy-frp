# easy-frp

This repository is for easy deployment of [`frp`](https://github.com/fatedier/frp) in IEEE P21451-1-5 standard's demonstration system.

We assume you log in as the super user, though it is **strongly recommended against** in practical deployment.

## 1. Common Steps

```shell
cd /root/
git clone https://github.com/ieee-p21451-1-5/easy-frp.git
```

## 2a. Configuration for Cloud Server

### Deploying `frp` Server and Traffic Monitoring Service

```shell
cd /root/easy-frp/
git update-index --assume-unchanged ./frps.ini # to make git ignore changes in the configuration file
vim ./frps.ini # and change the username & password for Dashboard 
cp ./systemd/frp-server.service /etc/systemd/system/
cp ./systemd/frps-traffic.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable frp-server.service frps-traffic.service
```

Reboot the system.

### Viewing Logs

Before running the following commands, change the `<date_and_time>` part to appropriate value.

To view `frp` server's log:

```shell
tail -f /root/easy-frp/logs/frp-log-<date_and_time>
```

To view the records of inward SNMP packets: 

```shell
tail -f /root/easy-frp/logs/frps-traffic-log-<date_and_time>
```

### Dashboard

Go to http://YOUR_ADDRESS:7500, where `YOUR_ADDRESS` is the IP address of your cloud server, and log in with the username and password predefined in `frps.ini`.

Then, feel free to browse the traffic statistics of the `frp` server using the web UI. 

## 2b. Configuration for NCAP

### A Prerequisite

Since Raspberry Pi doesn't have any [RTC](https://en.wikipedia.org/wiki/Real-time_clock), in its early stage of booting, the system time is "somewhen" on January 1, 1970 ([Unix epoch](https://en.wikipedia.org/wiki/Unix_time)). To avoid such archaic (and incorrect, of course) timestamps in the naming of log files, we'd better start services after the system clock has been synchronized through Internet. Therefore, we crafted a special service named `check-sync.service`, which will finish its initialization process only if the system clock has been synchronized. Having `check-sync.service`, we can make another service start with a correct system time, which is desired in a lot of cases. 

If you have set up the NCAP following the steps in [this page](https://github.com/ieee-p21451-1-5/demo-ncap),  `check-sync.service` should have already been installed.

### Deploying `frp` Client

```shell
cd /root/easy-frp/
git update-index --assume-unchanged ./frpc.ini # to make git ignore changes in the configuration file
vim ./frpc.ini # and change the IP address of cloud server
cp ./systemd/frp-client.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable frp-client.service 
```

Reboot the system.

### Viewing Logs

To view `frp` client's log (replace the `<date_and_time>` part with appropriate value):

```shell
tail -f /root/easy-frp/logs/frp-log-<date_and_time>
```

