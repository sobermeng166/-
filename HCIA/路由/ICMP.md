ICMP：Internet control massage protocol 因特网控制协议

![image1](D:/note/HCIA/resources/a15f46e4362f4e479897a91f9463830e.jpg)

用于测试网络可达性
使用ping、tracert等命令调用

![image2](D:/note/HCIA/resources/8d488cd21ef54608857ff26c15518fbb.jpg)

ICMP的格式：
![image3](D:/note/HCIA/resources/fc9bc7aca0f24b3fb52df5d917b30bcd.jpg)

![image4](D:/note/HCIA/resources/bbece3db97c84405b77a9fe6e9a8ab2e.jpg)

ICMP的类型：echo request 回响请求
 echo reply 回响应答

Type 类型和 Code 代码的组合：
![image5](D:/note/HCIA/resources/770d068af73a4dc2a093ffe5bf76afd5.jpg)

| 命令    | 备注           |
|---------|----------------|
| Ping    | 测试网络连通性 |
| tracert | 显示经过的路径 |

Ping 参数：
![image6](D:/note/HCIA/resources/b243922183c5473ea0e58705e459f5be.jpg)

tracert参数：
![image7](D:/note/HCIA/resources/5ca20163b6be4dfaa68b05456a70e6c7.jpg)

Ping 常见问题：
| 成功 | 对方成功回响 |
|----|----|
| 超时 | 对方主机不在线、屏蔽 （不在线-有对方MAC地址缓存，对方可能关机，平并-对方开启了策略“如防火墙”） |
| 传输失败 | 物理链路/网卡问题，网关未指定 |
| 无法访问 | 未获取到MAC地址，导致无法进行ICMP封装 |

![image8](D:/note/HCIA/resources/22a86b532954458a93f9ddc77485452b.jpg)

![image9](D:/note/HCIA/resources/fc3a50d350f74fae9096bd8a2d2dcb4a.jpg)

![image10](D:/note/HCIA/resources/818456265be4463e8d0b7e3b04526903.jpg)

![image11](D:/note/HCIA/resources/6b8a8e34dac54f9eab98cd83ff9a32a2.jpg)

