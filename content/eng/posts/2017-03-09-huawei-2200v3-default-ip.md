---
title: Huawei 2200 v3 default ip addresses and password
date: 2017-03-09
categories:
- hardware
---

Today I tested new storage system: _Huawei OceanStor 2200 V3_. And I really liked this system.
This is the third model of the data storage system of this manufacturer with which I happened to work.

Some notes about default IP adresses of this system:

* The default IP addresses of the management network ports on controllers A and B are respectively __192.168.128.101__ and __192.168.128.102__, and the default subnet mask is 255.255.0.0.
* The default internal heartbeat IP addresses are __127.127.127.10__ and __127.127.127.11__, and the subnet mask is 255.255.255.0.
* The default IP addresses of maintenance network ports are __172.31.128.101__ and __172.31.128.102__, and the subnet mask is 255.255.0.0.

You can change management ip via web, ssh or old school serial port.

To see the current settings of management ip use command: _show system management\_ip_.

```bash
admin:/>show system management_ip

  Port ID            : CTE0.A.H4
  IPv4 Address       : X.X.X.X
  Subnet Mask        : X.X.X.X
  IPv4 Gateway       : X.X.X.X
  IPv6 Address       : --
  IPv6 Prefix Length : --
  IPv6 Gateway       :
-------------------------------------
  Port ID            : CTE0.B.H4
  IPv4 Address       : X.X.X.X
  Subnet Mask        : X.X.X.X
  IPv4 Gateway       : X.X.X.X
  IPv6 Address       : --
  IPv6 Prefix Length : --
  IPv6 Gateway       :
```

To change the addresses use command: _change system management\_ip eth\_port\_id ip\_type mask [gateway]_.

* eth_port_id - Port ID. To obtain the value, run show system management_ip.
* ip_type - IP address type. Possible values are ipv4_address and ipv6_address.
* mask - Subnet mask of the management network port.
* gateway - Gateway of the management network port.

Additional information can be found:

1. OceanStor 2200 V3&2600 V3 Storage System Installation Guide.
2. OceanStor 2200 V3&2600 V3 Storage System Command Reference.