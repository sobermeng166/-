ARP：address resolution protocol 地址解析协议

![image1](D:/note/HCIA/resources/eea54d88cf6d41eda271fb3d1180fb32.jpg)
目的MAC不能不存在，负责完成不了封装，于是出现ARP

![image2](D:/note/HCIA/resources/ab3e588178214c348d6efb8988f8770d.jpg)

ARP报文的类型分为request请求和reply/respond回应

ARP请求：
![image3](D:/note/HCIA/resources/e280e367c5974593abc01f396346d799.jpg)

![image4](D:/note/HCIA/resources/7e565fcbc8ea42e18de1fe159b257c85.jpg)
ARP请求发送的类型为广播帧 （同一广播域的主机都会收到）

ARP响应：
![image5](D:/note/HCIA/resources/c766d95e4f4e4a8e9246d2273017450f.jpg)

![image6](D:/note/HCIA/resources/d6337d4734ab456b976b0d574a179969.jpg)
ARP响应的类型为单播帧 （可以使用软件修改为广播-ARP欺骗）

ARP缓存表：获取到的MAC地址会存放在该表

![image7](D:/note/HCIA/resources/f0c54088066348789f5fcfba02b3e9c2.jpg)

![image8](D:/note/HCIA/resources/7a2925af1e6b4ead99d61c232c50cc51.jpg)

| 命令   | 备注        |
|--------|-------------|
| Arp -a | 查看ARP缓存 |
| Arp -d | 清空ARP缓存 |

ARP欺骗：攻击者发送“无故ARP响应”来伪装其他设备
![image9](D:/note/HCIA/resources/163e508fc9274ee38a168df3c3f83dd6.jpg)

![image10](D:/note/HCIA/resources/05dfda6e7f734013916fc7b30228b663.jpg)
用来检测配置/修改的IP地址是否重复

![image11](D:/note/HCIA/resources/bece2a990e35448089683d03d52c8836.jpg)
连续发送3次来检测地址有没有冲突

![image12](D:/note/HCIA/resources/bcd465b898a04a3d9654130d24986dfa.jpg)
ARP报文的传播范围仅在一个广播域
