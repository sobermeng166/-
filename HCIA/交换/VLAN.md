![image1](D:/note/HCIA/resources/0ea9852c69ae4a0a8858e46394e6bf38.jpg)

VLAN技术背景：

![image2](D:/note/HCIA/resources/447a83162258447096ce2118127a68e8.jpg)

![image3](D:/note/HCIA/resources/b7128b6a96444cc0a83558e52ba550b6.jpg)

划分VLAN，将广播域范围减小

![image4](D:/note/HCIA/resources/ed94609a832a47cb8955be7393dbb01b.jpg)

![image5](D:/note/HCIA/resources/d342999e46f841468c3a4bbd65eccc6b.jpg)

![image6](D:/note/HCIA/resources/00bdd030ff3b426387e6a43eb1232f56.jpg)

VLAN优点：
- 有效控制广播域范围
- 增强局域网的安全性
- 灵活构建虚拟工作组
- 简化网络管理

![image7](D:/note/HCIA/resources/e8253e67b24d4a1fa354ff9095a5b0d9.jpg)

VLAN概述：Virtual LAN 虚拟局域网
- 将一个物理局域网在逻辑上划分成多个广播域
- 1 VLAN = 1 广播域 = 1 子网（划分最好一个子网一个VLAN）
- 广播不会在不同VLAN间转发，而是限制在相同的VLAN中
- 不同VLAN间的设备默认无法通信

VLAN范围：0~4095 （0和4095保留，1为默认）

VLAN划分：基于端口最常见

![image8](D:/note/HCIA/resources/ae5c04e4bb9c4e3a8007729550ee43de.jpg)

VLAN标签介绍：

![image9](D:/note/HCIA/resources/b5dc666b3f374b5fbfcaf0c7f8754ec0.jpg)

![image10](D:/note/HCIA/resources/f9fda914c9e745619e54d4d5d4622122.jpg)
- IEEE 802.1q：又称dot1q，是VLAN的正式标准，对Ethernet帧格式进行修改，在源地址和类型字段中插入了4字节的802.1q tag
每台支持802.1q协议的交换机发送的数据帧都会包含VLAN ID，以指明数据帧属于哪一个VLAN。因此，在一个VLAN交换网络中，以太网帧有以下两种格式
| 无标记帧 untagged frame | 原始的数据帧，未加入4字节802.1q tag的字段 |
|-------------------------|-------------------------------------------|
| 有标记帧 tagged frame   | 插入了4字节802.1q tag的字段               |

路由器和终端设备发送的数据帧默认是untagged frame，默认也识别不了tagged frame

PVID：Port Vlan identification 端口VLAN标志

指明该接口属于的VLAN

VLAN链路类型：
| 类型                     | 备注                               |
| ------------------------ | ---------------------------------- |
| 接入链路 Access Link     | 一般用于连接主机或路由器直接的链路 |
| 干道/中继链路 Trunk Link | 一般用于连接交换机之间的链路       |

![image11](D:/note/HCIA/resources/7590fadde53f443da7cd834fb06c804b.jpg)

**Access的工作原理：**

| Access                       | 过程                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| 接入链路接收数据帧的工作过程 | 接收一个untagged的数据帧会打上接口的PVID<br/>接收一个tagged的数据帧会比较与接口的PVID是否一致（一致接收，不一致丢弃） |
| 接入链路发送数据帧的工作过程 | 发送一个数据帧会剥离VLAN （也就是丢弃dot1q字段）             |

**Trunk的工作原理：**

| trunk                                                        | 过程                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| 干道/中继链路接收数据帧的工作过程                            | 接收一个untagged的数据帧会打上接口的PVID<br/>接收一个tagged的数据帧会查看tagged List是否存在<br/>（存在接收，不存在丢弃） |
| 干道/中继链路发送数据帧的工作过程<br/>（最多一个数据帧是untagged形式发送） | 发送一个数据帧会查看tagged list和PVID<br/>（tagged list表中存在则直接发送，如果PVID一致会剥离VLAN） |


华为私有接口类型：**Hybrid 混杂接口**

可以任意指定数据帧发送或接收是否携带tagged

![image12](D:/note/HCIA/resources/2cf952066ee84fc093fb7641b8782eed.jpg)

（任意数据帧是untagged形式发送）

如：port hybrid tagged/untagged 的作用：

1.将VLAN放入tagged list中

2.允许VLAN以tagged/untagged的形式通过

**交换机的工作原理：**

![image13](D:/note/HCIA/resources/6b2169e58a42459486213025432cec6d.jpg)

![image14](D:/note/HCIA/resources/4f4cfb44ff2d406995f11af9d65c44ea.jpg)

VLAN间通信限制：每一个VLAN都是独立的广播域，不同VLAN之间隔离，因此不同VLAN的节点之间是无法直接访问

![image15](D:/note/HCIA/resources/4f222d3175c949008a332d60ee4f3374.jpg)

VLAN间通信方法（路由）：

![image16](D:/note/HCIA/resources/39763de436fd4d1ea0e49abf6b82b524.jpg)

使用路由器完成不同VLAN通信 （缺点：每一个VLAN就需要绑定一个物理接口）

![image17](D:/note/HCIA/resources/afe3f16534ab4ed9b3f2977b8ca0c38e.jpg)

使用一个接口的子接口（虚拟接口），来绑定VLAN大大减少了资源消耗

交换机设置为Trunk，路由器如何识别VLAN？

Dot1q termination vid 10 作用：

该子接口与VLAN10绑定，收到VLAN10就剥离VLAN，查看路由表执行路由转发，转发在打上转发接口的PVID

![image18](D:/note/HCIA/resources/99d883ba86684b82a7cb0f7ec966ae22.jpg)

路由器一般用作出口设备（广播域太大），且价格较贵，使用路由器实现VLAN间通信不经济

![image19](D:/note/HCIA/resources/35e74b5ecc3d464db06d849d21afc1af.jpg)

使用具有路由功能的交换机实现VLAN间通信

**VLAN配置：**

**命令：**

```
vlan 10  ##创建单个vlan
vlan batch 10 20 ##创建多个vlan
port link-type access/trunk/hybrid   ##配置接口类型
port default vlan 10  ##配置access关联VLAN/PVID
port trunk allow-pass vlan 10 ##配置trunk允许VLAN通过（默认只允许VLAN1通过）
port trunk pvid vlan 10  ##配置trunk的PVID
port hybrid tagged/untagged vlan 10  ##配置hybrid标记VLAN
port hybrid pvid vlan 10  ## 配置hybrid的PVID
display vlan  ##验证vlan
display port vlan  ##验证VLAN
dot1q termination vid 10 ## 子接口和VLAN关联
arp broadcast enable  ##开启子接口的ARP广播功能
portswitch  ##配置接口工作为二层
undo portswitch ##配置接口工作为三层
```

