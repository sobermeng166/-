![image1](D:/note/HCIA/resources/404ebab340e54601863c0bf362dd6186.jpg)

- 传输层提供端到端的连接（会话之间）
- 网络层提供点到点的连接（节点之间）

![image2](D:/note/HCIA/resources/8a5aa55e5a104383a671c79e34c3012c.jpg)

根据端口号可以区分不同的应用协议

传输层端口：Port

![image3](D:/note/HCIA/resources/5730c2985b34439688d775ac50e63290.jpg)

端口数量：216

![image4](D:/note/HCIA/resources/9851e5c2e62943669e3e190316ee8269.jpg)

0~1023 属于公认端口/知名端口（给一些重要的协议使用的端口）

1024~49151属于注册端口/登记端口（应用注册使用的端口）

49152~65535属于私有端口/动态端口（主机/客户端使用的端口）

- 端口是根据需求自行更改的
- 可以通过更改端口可以让非信任用户访问不到应用
- 如FTP的端口默认为21，修改端口为9999，让非信任用户访问不到FTP服务器

![image5](D:/note/HCIA/resources/aff804fe89474c9dbc9fc16f2d741f7b.jpg)

客户端（source port 49152~65535）

服务器（source port 0~49152）

端口对应了一种应用协议，真正提供服务的是服务器

传输层协议：
<table>
<colgroup>
<col style="width: 17%" />
<col style="width: 82%" />
</colgroup>
<thead>
<tr class="header">
<th>协议</th>
<th>备注</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>TCP</td>
<td><p>Transmission control protocol 传输控制协议</p>
<p>可靠的、面向连接的协议</p>
<p>传输效率低，类似于打电话</p></td>
</tr>
<tr class="even">
<td>UDP</td>
<td><p>User datagram protocol 用户数据报协议</p>
<p>不可靠、无连接的服务</p>
<p>传输效率高，类似于群聊</p></td>
</tr>
</tbody>
</table>

![image6](D:/note/HCIA/resources/54b2503e68ec462eb57346ebd544b007.jpg)

TCP在通信前需要建立关系来确认之间状态

![image7](D:/note/HCIA/resources/35aeed13d08847079c558a0856251f0d.jpg)

UDP在通信前不需要建立关系来确认之间的状态

TCP与UDP数据包结构对比：

![image8](D:/note/HCIA/resources/a88cdb543c284e5298b2f4b5c9ce558b.jpg)

![image9](D:/note/HCIA/resources/123747e090d643f8b601433016abb15c.jpg)

![image10](D:/note/HCIA/resources/d31b46e3a0bb4bf0bf73f10cbacb2af0.jpg)

![image11](D:/note/HCIA/resources/01a414d61d23409fa7ed2b1442e59924.jpg)

可靠，效率低

TCP会话的建立-三次握手：涉及标志位SYN,ACK

![image12](D:/note/HCIA/resources/cc807b2ab6fd465fa835ec7fdca0e239.jpg)

![image13](D:/note/HCIA/resources/7fc90ecf301249f889d76bca462c2498.jpg)

三次握手机制类似打电话：（确保身份状态的可靠性）

甲：你是小王？

乙：我是小王，你是小刘？

甲：好的，我知道了

第一次握手：

![image14](D:/note/HCIA/resources/a1a3316fdc8c40b2b6f093b686fed999.jpg)

第二次握手：

![image15](D:/note/HCIA/resources/c89460f7bdec4f5b9dad9b9f60ca13ab.jpg)

第三次握手：

![image16](D:/note/HCIA/resources/764b14f0c79d430a8c6dbaffc308662c.jpg)

TCP会话的确认：对每个数据包都会进行确认（影响资源的消耗，推出滑动窗口机制，只对部分进行确认）

![image17](D:/note/HCIA/resources/46bb51016b2c477dbc0275d13a8203f3.jpg)

- TCP会话的拥塞和流量控制
![image18](D:/note/HCIA/resources/a4ec5d4e861a49f9ab6127eeb316dd5d.jpg)

根据窗口机制来控制网络拥塞（网络拥塞，主机接收服务器的数据不过来，服务器接收主机的请求不过来，可以根据窗口大小来调整）

TCP会话的结束-四次握手：涉及ACK、FIN

![image19](D:/note/HCIA/resources/633a7dbe6e9648779e6e59d3f4825cc5.jpg)

![image20](D:/note/HCIA/resources/af5b6e57892f4574a9abadeb116d131f.jpg)

- TCP的三次握手一定是三次交互报文，四次握手可能不会有四次交互报文（主机直接拔电）

网络中最霸道的攻击 DDos

![image21](D:/note/HCIA/resources/cde50e34be6046a0a88dadf12b27e963.jpg)

![image22](D:/note/HCIA/resources/8268731f54c5462dbf00dee53be564af.jpg)

黑客控制僵尸网络向服务器发送TCP SYN ，并不会对服务器的回应。

UDP：用户数据报协议

![image23](D:/note/HCIA/resources/56f71793d1314702b4dd94faccab5163.jpg)

![image24](D:/note/HCIA/resources/37377b3e0f6e4919a291e504f5c378d8.jpg)

TCP与UDP的区别：
| 传输控制协议TCP        | 用户数据报协议UDP                    |
|------------------------|--------------------------------------|
| 面向连接               | 无连接                               |
| 可靠传输               | 尽力而为的传输                       |
| 支持流控及窗口机制     | 无流控及窗口机制                     |
| 仅支持点对点通信       | 支持任意通信方式（点对点，点对多点） |
| 多用于注重数据的完整性 | 不要求数据的完整性，开销小           |

