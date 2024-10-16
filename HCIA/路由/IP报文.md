IP：Internet protocol 因特网协议

![image1](D:/note/HCIA/resources/ef746a3a515a48a484520e68aa6079ad.jpg)

网络层占主导地址协议：IP

IP报文结构：

![image2](D:/note/HCIA/resources/73d578795f4b4dada396fe21fcff3141.jpg)

![image3](D:/note/HCIA/resources/c49b6e3d5eec412c99b896848a279d25.jpg)

- 版本version：标明IP报文的版本（ v4 或 v6）
- 头部长度header length：头部长度（最小为20B，最大为60B）
- 总长度total length：头部长度和数据长度

分片：当数据包的大小超过数据链路层的MTU就需要分成多份数据包传输

![image4](D:/note/HCIA/resources/abc546c444ce4c0e9834d9723b237276.jpg)

分片之后重组依靠：标志 identification

 标识符 flags

 片偏移 fragment offset

![image5](D:/note/HCIA/resources/8b59c0846268416baad51a06326f65e3.jpg)

标志：用来标识同一个数据包

标识符：保留 ：未使用

 分段：置位表示不能分片 （遇到超过MTU的直接丢弃）

 更多分段：置位标识还有分片（未置位表示这是最后一个分片）

片偏移：说明该数据包在重组后的位置

TTL：time to live 生存时间 （生命值）
- 防止数据包在网络中无休止的传递（防环）
- 每经过一次路由（路由转发）TTL值就会减1
- 当TTL值=0，丢弃数据包，并告诉源地址

![image6](D:/note/HCIA/resources/ae83d9591dab48938ef8defbc571fd8e.jpg)

![image7](D:/note/HCIA/resources/a266f9dc9de34f169279e7a39706022b.jpg)

利用TTL特性，可以实现路由跟踪技术，排错的重要方法之一
- 相关命令：ping -I 或 tracert
![image8](D:/note/HCIA/resources/8b90173c4deb46afb9a1af76e48c055c.jpg)

![image9](D:/note/HCIA/resources/749df18087a84b32a0a080e7dc7809c9.jpg)

tracert会一次发送3个igmp echo request报文

Protocol 协议：用来标识上层使用的协议

![image10](D:/note/HCIA/resources/ec97a165a55845f6a2e59d272c37a5ed.jpg)

![image11](D:/note/HCIA/resources/7fc50b5ef4a74744bf492559b03584c5.jpg)

熟悉的协议号
| **协议号**                       |
|----------------------------------|
| 1.ICMP 因特网控制报文协议  |
| 2.IGMP 因特网组报文协议   |
| 6.TCP 传输控制协议     |
| 17.UDP 用户数据报协议     |
| 41.IPV6 因特网v6         |
| 47.GRE 通用路由封装协议  |
| 89.OSPF 开放式最短路径优先 |
| 103.PIM 协议无关报文      |
| 112.VRRP 虚拟路由冗余协议    |
