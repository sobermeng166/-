![image1](D:/note/HCIA/resources/a2ac9a9907754ccf8ad02172f188f9ad.jpg)

DHCP：Dynamic Host Configure Protocol 动态主机配置协议
- 从BOOTP（Bootstrap Protocol）协议发展而来
- UDP封装，服务器使用端口67，客户端使用端口68
- 动态分配网络信息（IP地址、子网掩码、网关、DNS服务器等）
- 分配给客户端的网络信息是有租约的

![image2](D:/note/HCIA/resources/f6220aebfa6b418993d750830bb37fc0.jpg)

DHCP角色组成：

![image3](D:/note/HCIA/resources/20cefd785ffc4d8e822a8052a430c129.jpg)

| DHCP Cilent 客户端 | 请求网络信息的用户             |
|---------------------|--------------------------------|
| DHCP Server 服务器  | 能够提供DHCP功能的设备         |
| DHCP Relay 中继    | 一般为路由器或三层交换机等设备 |

DHCP报文结构：

![image4](D:/note/HCIA/resources/26db71849cab45a0bce8fa80a141b99b.jpg)

![image5](D:/note/HCIA/resources/9fba2e88cc694688803bb3bc563e489d.jpg)

| 报文类型           | 备注                                                |
|--------------------|-----------------------------------------------------|
| DHCP Discover 发现 | 客户端寻找DHCP服务器                                |
| DHCP Office 提供   | 服务器响应DHCP Discover报文，该报文也携带了网络信息 |
| DHCP Request 请求  | 客户端请求服务器对网络信息确认，或者续约租期        |
| DHCP ACK 确认      | 服务器对DHCP Request报文确认响应                    |
| DHCP NAK 不确认    | 服务器对DHCP Request报文的拒接响应                  |
| DHCP Release 释放  | 客户端释放网络信息通知服务器                        |

![image6](D:/note/HCIA/resources/3117f6694dc843409bd7fc3360a0d230.jpg)

![image7](D:/note/HCIA/resources/7ec24807d49d4b74abd4f6d6bf4cd43c.jpg)

注：Office和ACK报文也可以说是广播包，因为服务器只是根据MAC地址回应，根本没有看三层 （在ACK确认之后才是真正的使用地址）

 NAK报文出现1.IP地址可能已经被使用

 2.租期未到网络信息还存在，换了DHCP服务器 （回家，请求续约，但是服务器根本不存在该网络信息）

DHCP工作流程：

![image8](D:/note/HCIA/resources/48f97e3979c8494a859576074a4efff4.jpg)

DHCP租期更新：

![image9](D:/note/HCIA/resources/5a9f5cb3418140d59df5989e9b63d753.jpg)

![image10](D:/note/HCIA/resources/a7cb50eab61e41558c8688e3ce76f14d.jpg)

在租期时间过50%后，主机会自动发送DHCP Request报文请求DHCP服务器重新续租

DHCP重绑定：

![image11](D:/note/HCIA/resources/974c241c2ad846fd9526862008325084.jpg)

在租期时间过50%一直请求服务器，但服务器未响应，客户端在87.5%会发送DHCP Request报文请求所有DHCP服务器分配网络信息 （注：是以广播的形式发送）

![image12](D:/note/HCIA/resources/734c6c582e1e40d4b068f595f89db584.jpg)

无法获取到DHCP服务器分配的网络信息，Windows客户端会自动使用169.254.0.0/16地址，供临时通信

无法获取从DHCP服务器获取网络信息的排错：

1.检测物理链路，驱动…..

![image13](D:/note/HCIA/resources/6f1e0a2e37e2475dbca1e30120944103.jpg)

![image14](D:/note/HCIA/resources/8bfecf2690d44df890a3ec615c4c3cad.jpg)

2.Windows的DHCP client服务未开启

![image15](D:/note/HCIA/resources/47990385fda34f89af910e549e25ea1f.jpg)

3.手动配置地址，测试于DHCP服务器的连通性

![image16](D:/note/HCIA/resources/5523743793a74ccaa8ba5d9576b4e746.jpg)

租期设置建议：

![image17](D:/note/HCIA/resources/2db374898c9b430b93b48dadec3cf7e9.jpg)

释放DHCP服务器分配的网络信息：

![image18](D:/note/HCIA/resources/0c7cb2cf95054800b07cbe679d792f48.jpg)

DHCP地址池：所分配地址的集合

![image19](D:/note/HCIA/resources/37b3d0ce19c3410c88ab65f1f1ba7f39.jpg)
- 地址池的分类：接口地址池和全局地址池
- 同时配置，接口地址池生效

DHCP配置：
| 命令 | 备注 |
|----|----|
| Dhcp enable | 开启DHCP功能 |
| dhcp selcet interface | 地址池关联接口 |
| dhcp server dns-list 114.114.114.114 223.5.5.5 | 配置接口地址池的DNS服务器 |
| dhcp server lease day 1 hour 12 | 配置接口地址池的租期，默认1天 |
| dhcp server excluded-ip-address 192.168.10.100 | 配置接口地址池排除的地址 |
| dhcp server static-bind-ip-address 192.168.10.100 mac-address 0000.0000.0001 | 配置静态绑定 |
| dhcp select global | 关联接口和全局地址池绑定 |
| dhcp select relay | 关联接口开启中继代理 |
| dhcp relay server-ip 192.168.10.254 | 指定DHCP服务器的地址 |
| display ip pool interface vlanif10 | 验证接口地址池的信息 |
| display ip pool name huawei used | 验证全局地址池的信息 |
