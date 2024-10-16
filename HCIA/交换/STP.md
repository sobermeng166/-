# STP生成树协议

STP的背景：为了实现二层设备（Ethernet协议）之间的可靠性，企业网络通常拿多台设备或链路实现链路冗余备份，会引起环路

![image1](D:/note/HCIA/resources/97df9c1be0ae469ea46e3372c2974b48.jpg)

二层网络设计的需求和问题：
- 为了提高可靠性，交换机之间会通过多条链路相连，从而避免单点故障。
- 但也会带来一些致命的环路问题。
![image2](D:/note/HCIA/resources/a551716e6d79423093fd468de6191818.jpg)

![image3](D:/note/HCIA/resources/17d06d85359c4075bbd7756f24721c28.jpg)

```
环路问题给用户带来的后果：网络体验差、延迟高、丢包
环路引起的问题：
	--极大占用链路带宽资源和设备资源，造成大量的垃圾流量
	--网络广播风暴
	--MAC地址表项不稳定
	--重复的帧拷贝
```

![image4](D:/note/HCIA/resources/9fc821ea5c914feeaa10f284fc432157.jpg)

![image5](D:/note/HCIA/resources/9d93f741d34f41e58be271602334bacc.jpg)

![image6](D:/note/HCIA/resources/f3ddce43e8a84e169092985956eb08af.jpg)

![image7](D:/note/HCIA/resources/2419d60c0c144d1eb136e89ee6aa1573.jpg)

STP：Spanning Tree Protocol生成树协议

两大作用：
| 功能     | 备注                                                       |
|----------|------------------------------------------------------------|
| 消除环路 | 通过阻断冗余链路来消除网络中可能存在的环路                 |
| 链路备份 | 当正常工作的链路出现问题，激活备份链路，及时恢复网络连通性 |

![image8](D:/note/HCIA/resources/f6792bf0a4dc497e85bad0bf9d1d730b.jpg)

STP操作：通过构建一颗无环的树

![image9](D:/note/HCIA/resources/fd29825eed3c437d8d06556778eb6433.jpg)

BPDU：Bridge Protocol Data Unit 桥协议数据单元（桥就是交换机）
- 使用组播地址：01-80-C2-00-00-00
![image10](D:/note/HCIA/resources/c8f213d8a820418aa22967448f5e94b9.jpg)

PID：STP（无论是STP、RSTP、MSTP都是STP）

PVI：标识使用的是什么模式（STP、RSTP、MSTP）

BPDU Type：BPDU 的类型
- 配置BPDU：configuration
- 选举根交换机以及确定每个交换机的角色和状态。
- 在初始过程中，每个桥都主动发送配置BPDU。
- 在网络拓扑稳定后，只有根桥主动发送配置BPDU，其他交换机在收到上游传来的配置BPDU后，才会发送自己的配置BPDU。
- 发送周期为Hello Time。
- 老化时间为Max Age。
- 拓扑变更通告BPDU：TCN BPDU
下游交换机感知到拓扑变化时向上游发送的拓扑变化通知。

配置BPDU：

![image11](D:/note/HCIA/resources/a5adb03350ca4fc6a82930312ee8984a.jpg)

拓扑变更BPDU：

![image12](D:/note/HCIA/resources/404ba6f2a88a4806814d7a15d5f2750d.jpg)

BPDU字段详解：

![image13](D:/note/HCIA/resources/7130f61caad34b43b9427c796ebd36eb.jpg)

选举桥角色和端口状态靠该4个字段

| 参数              | 描述                                                       |
| ----------------- | ---------------------------------------------------------- |
| Root ldentifier   | 发送此配置BPDU的交换机所认为的根交换机的标识               |
| Root Path Cost    | 从接收此根桥的配置BPDU的交换机到达根交换机的最短路径总开销 |
| Bridge identifier | 标识自己的BID                                              |
| Port Identifier   | 发送此配置BPDU的交换机端口的端口标识                       |

![image14](D:/note/HCIA/resources/026a5acdacca4225a740ebb240f813a9.jpg)

从高位比较再到低位；值越小越优先。（选值4096的倍数）

![image15](D:/note/HCIA/resources/8f237781442c4f32b9e5573c9c5fa1d2.jpg)

从高位比较再到低位；值越小越优先（端口编号与实际接口无关，选值16的倍数）

![image16](D:/note/HCIA/resources/910d29a23f1640889c213a586e1837ad.jpg)

（旧的链路开销标准，现在链路的带宽都不止10G，在计算带宽时存在不合理）

![image17](D:/note/HCIA/resources/35a5eefda4cb4534bcc940d205f75f61.jpg)

（华为设备所支持的链路开销标准，使用链路聚合的开销=开销标准/链路数量）

![image18](D:/note/HCIA/resources/efe229378fa84aec8c90bccd08f1d372.jpg)

（从根桥发出的开销为0，在根据自己所有收到的接口到根桥的开销相加，取最小的开销值，就是根路径开销）

STP选举过程：（在STP中优先级是越小越好）
- BID最小的成为根桥（先比较优先级在比较MAC）
![image19](D:/note/HCIA/resources/f5ce8b54076d4ab1a981163ae13691c1.jpg)

（开始都会发送BPDU，在收到与自己的参数比较，然后清楚自己的角色）

![image20](D:/note/HCIA/resources/17b2d19b25124d8196de178706b988f5.jpg)

（先看RPC在看对端BID，最后比较对端PID和本地PID）

![image21](D:/note/HCIA/resources/bffea258947d43eaaedcc9cb4ab0249b.jpg)

（在每条链路上选举一个指定端口负责数据的收发，“根路径开销”是比较端口的RPC越小越好，所以根桥的端口都是0，为指定端口//当拿一根线插在同一个根桥时，根桥的端口会比较到PID，就不会都是指定端口，一个为预备端口），剩下的端口就是预备端口

**STP的端口状态：**

| STP端口状态    | 接收BPDU | 转发BPDU | 学习MAC | 转发数据 | 过渡状态 | 稳定状态 |
|----------------|----------|----------|---------|----------|----------|----------|
| Disabled禁用   | ×       | ×        | ×       | ×        | ×        | √        |
| Blocking阻塞   | √        | ×        | ×       | ×        | ×        | √        |
| Listening监听  | √        | √        | ×       | ×        | √        | ×        |
| Learning学习   | √        | √        | √       | ×        | √        | ×        |
| Forwarding转发 | √        | √        | √       | √        | √        | √        |

1.禁用 disable 未开启STP协议

2.阻塞 blocking 接收BPDU

3.侦听 listening 接收BPDU 转发BPDU

4.学习 learning 接收BPDU 转发BPDU 学习MAC地址

5.转发 forwarding 接收BPDU 转发BPDU 学习MAC地址 转发用户流量

**STP的计数器：**

| 计时器           | 备注                                                         |
| ---------------- | ------------------------------------------------------------ |
| Hello            | 2S，根桥发送BPDU的间隔                                       |
| Forwarding Delay | 15S，监听和学习的持续实际（监听到学习需要15S，学习到转发需要15S） |
| MSG Age          | 当前的年龄，每经过一个设备就加1（从根桥开始为0往下算），最大为20，超过20则丢弃.（不建议接太多设备影响交换机性能） |
| Max Age          | 20S，保持阻塞的最大时间（每2秒收到一次，通过比较最后阻塞，若20秒没收到就不再阻塞） |

一个预备端口从阻塞状态到转发状态的时间：50S

![image22](D:/note/HCIA/resources/faff13f84c984a909052b1fd596d4056.jpg)

STP的端口状态转换：

![image23](D:/note/HCIA/resources/388921662a4f4b8dae93178ccd0576b5.jpg)

![image24](D:/note/HCIA/resources/08685b9476284ef487751ebe36b547d2.jpg)

STP拓扑变化：

![image25](D:/note/HCIA/resources/bb86208584de41e297aa03b84b8c9040.jpg)

根桥故障需要等待50S，网络才会恢复正常（20S老化时间和30S变成转发状态）

![image26](D:/note/HCIA/resources/c41d66cf2d904a63abd012f9e4eefcbd.jpg)

直连链路故障可能需要等待30S（检测到自己的链路与根桥断了，立马将预备端口从阻塞状态变成转发状态需要经过2个forwarding delay）

![image27](D:/note/HCIA/resources/38f40992c515477e9f6165f3f371c301.jpg)

（当非直连设备故障后，收到对端发来的BPDU并不是最优的，接收但不会改变该角色，等到老化时间在会改变角色状态）

![image28](D:/note/HCIA/resources/39f8912804a045bcb754985d91110c81.jpg)

（MAC地址表老化太长，链路角色变换，但是MAC地址还是原来（要么等待300S或ARP老化））

**解决方法：**

![image29](D:/note/HCIA/resources/3f63e7b43e3a464ca59e9a7f18af5482.jpg)

检测到拓扑变化的交换机通过根端口向根桥发TCN，上游交换机收到TCN后回应TCA，让下游交换机停止发送TCN，在通过根端口发送TCN直到根桥收到，根桥通过指定端口发送TC通知所有下游交换机把MAC地址表的老化时间300S变成15S。

BPDU字段中的Flags中：1000 0000最高位为1作为TCA

 0000 0001最低位为1作为TC

**STP的配置**

**命令:**

```
Stp mode stp  ## 调整STP的模式，默认MSTP

Stp priority 4096  ## 调整BID优先级值，0~61440，选值4096的倍数

Stp root primary / secondary
## 自动修改优先级，指定主/备根桥

Stp pathcost-standard（ dot1q-1998 | dot1q | legacy ）
## 配置计算路径开销值得标准
	开销标准：
	Legacy标准：cost=1~200000，华为私有
	802.1d标准：cost=1~65535
	802.1t标准：cost=1~200000000，默认选则
	
Stp cost 10   ## 修改STP开销

Stp port priority 144   ## 修改PID优先级，0~240，选值16的倍数

Display stp brief   ## 显示STP配置信息和参数

```

