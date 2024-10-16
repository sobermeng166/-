![image1](D:/note/HCIA/resources/227f44556648466ea64de7ed429b88b1.jpg)

GARP:Generic Attribute Regisration Protocol 通用属性注册协议
- 在交换机间分发、传播、注册某种信息（VLAN属性、组播地址等）
- 主要用于大中型企业网络中，用来提升管理交换机的效率
- 一种协议规范
![image2](D:/note/HCIA/resources/ae67a3f5d3f8456fa6ffd9d5b2f9120b.jpg)

GARP消息类型:
| 类型  | 备注               |
|-------|--------------------|
| Join  | 加入，端口加入VLAN |
| Leave | 注销，端口退出VLAN |
| Leave | 注销所有           |

![image3](D:/note/HCIA/resources/02ec98032f6f4f1689dbd56343f34cff.jpg)

![image4](D:/note/HCIA/resources/7fb73e0395c8434685c2c56ce5e0839b.jpg)

![image5](D:/note/HCIA/resources/0dc7b6399b21429cb9acef8d64677645.jpg)

GVRP：GARP VLAN Registration Protocol VLAN注册协议
- GVRP基于GARP的工作机制，是GARP的一种应用，传递VLAN信息

![image6](D:/note/HCIA/resources/4b8be27960a34ea5816d994b7b75f98c.jpg)

![image7](D:/note/HCIA/resources/fc4b1c297f6449ff8666e3ca6a5b944c.jpg)

VLAN分为常规（静态）和动态VLAN

GVRP的结构：

![image8](D:/note/HCIA/resources/a3434742bbd64243aeaf0c52ab1e5379.jpg)
- 工作于数据链路层
- 使用组播地址01：80：c2：00：00：21

GVRP的应用：
- 接收来自其他交换机的VLAN注册信息，并动态的更新本地的VLAN信息同步
- 将本地的VLAN注册信息向其他交换机传播，以便同一交换网内所有支持GVRP的设备VLAN信息同步
- 手动配置的VLAN是静态VLAN，通过GVRP创建的VLAN是动态VLAN
- GVRP传播的VLAN注册信息包括静态创建的VLAN信息和动态学习的VLAN信息

![image9](D:/note/HCIA/resources/ef2795b08db5446c8e4ba7b387dcade8.jpg)

收到VLAN注册信息会将端口进行绑定，分发的端口不会进行绑定

GVRP注册模式：

![image10](D:/note/HCIA/resources/cd1c281eb4ec4b2497cbf6720284a255.jpg)

Normal正常模式是默认模式 创建静态和动态都会发送VLAN注册

![image11](D:/note/HCIA/resources/99628b78fb0c4a42bc7a9a3d0f648ce5.jpg)

Forbidden禁止模式不会接收动态VLAN注册，同时删除所有学习到的VLAN （除VLAN1）

![image12](D:/note/HCIA/resources/668a2b50fcc841cba6772a351aa8adfe.jpg)

fixed固定模式不会发送和接收动态的注册信息，只会发送静态注册消息

GVRP配置：
| 命令 | 配置 |
|----|----|
| Gvrp | 全局开启GVRP，默认关闭 |
| Gvrp | 接口开启GVRP，接口类型必须是Trunk |
| Gvrp registration fixed/ forbidden/normal | 配置GVRP注册模式 |
| Display gvrp status | 查看GVRP状态 |

![image13](D:/note/HCIA/resources/d3a27d68c96545bcbc17dd0275698666.jpg)

