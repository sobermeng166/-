![image1](D:/note/HCIA/resources/4250f11f8d394b04b8f602f11428ac80.jpg)

![image2](D:/note/HCIA/resources/15066753cf074353861f45e139281ea2.jpg)

OSPF概述：Open shortest path first 开放式最短路径优先
- 大中型网络使用最广泛的IGP协议
- 链路状态路由协议
- 无类别路由
- 使用组播（224.0.0.5和224.0.0.6）
- 收敛快
- 以开销（cost）作为度量值
- 采用SPF算法可以有效的避免环路
- 触发式更新（以较低频率 （每30分钟）定期发送更新，被称为链路状态泛洪）
- 设置区域概率使得OSPF能够支持更大规模的网络（划分骨干区域和非骨干区域和特殊区域）
- 通过LSA（链路状态信息）的形式发布路由
- 支持手动汇总 （在ABR/ASBR上配置）

OSPF区域概述：
<table>
<colgroup>
<col style="width: 29%" />
<col style="width: 70%" />
</colgroup>
<thead>
<tr class="header">
<th>术语</th>
<th>备注</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>区域（Area）</td>
<td><p>为了适应大型网络，OSPF在AS内划分多个区域</p>
<p>区域是以接口划分</p>
<p>每个OSPF路由器只维护所在区域的完整链路状态信息</p></td>
</tr>
<tr class="even">
<td>区域ID（Area ID）</td>
<td><p>可以表示成一个十进制的数字，如：1</p>
<p>也可以表示成一个IP，如：0.0.0.1</p></td>
</tr>
<tr class="odd">
<td>区域优点</td>
<td><p>尽量减少LSDB大小</p>
<p>拓扑变化仅影响本区域内部</p></td>
</tr>
</tbody>
</table>

OSPF区域类型：
<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 66%" />
</colgroup>
<thead>
<tr class="header">
<th>类型</th>
<th>备注</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>骨干区域</td>
<td><p>area 0</p>
<p>骨干区域，也称为传输区域</p></td>
</tr>
<tr class="even">
<td>非骨干区域</td>
<td><p>area 0除外</p>
<p>非骨干区域，称为末端区域</p></td>
</tr>
</tbody>
</table>

划分多区域的作用：为了减轻运行OSPF路由器的压力

防环机制：划分了骨干区域和非骨干区域，所有非骨干区域通讯必须经过骨干区域中转

骨干区域传来的LSA不会再传回骨干区域

![image3](D:/note/HCIA/resources/4dd40e4c390a435ba0f7ad9e4f847296.jpg)

非骨干区域之间通信需要骨干区域转发（为了防止环路）

OSPF路由器角色：
<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 85%" />
</colgroup>
<thead>
<tr class="header">
<th>角色</th>
<th>备注</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>IR</td>
<td><p>internal router 内部路由器</p>
<p>所有接口都属于同一个区域</p></td>
</tr>
<tr class="even">
<td>BR</td>
<td><p>backbone router 骨干路由器</p>
<p>至少有一个接口属于骨干区域</p></td>
</tr>
<tr class="odd">
<td>ABR</td>
<td><p>Area border router 区域边界路由</p>
<p>连接多个不同的区域，至少有一个接口属于骨干区域</p></td>
</tr>
<tr class="even">
<td>ASBR</td>
<td><p>Autonomous system border 自治系统边界路由器</p>
<p>将其他路由协议学习到的路由以引入的方式到OSPF进程中</p></td>
</tr>
</tbody>
</table>

![image4](D:/note/HCIA/resources/a11e0296c49f418fbdc68880663439de.jpg)

![image5](D:/note/HCIA/resources/6a0a49daf0734cbd9de3484804b31e20.jpg)

OSPF核心工作流程：

1.发现并建立邻居

2.传播LSA（区别基于DV算法的路由更新）

LSA的内容 ：a.link state advertisement 链路状态宣告

 b.链路：路由器接口

 c.状态：描述接口信息（地址、掩码、开销、网络类型、邻居关系等）

3.将LSA泛洪到区域中的所有OSPF路由器

4.收集LSA创建LSDB（链路状态数据库）

5.使用SPF算法计算到达每个目标网络的最短路径，存放于路由表

OSPF三张表：
| 类型           | 含义                 |
|----------------|----------------------|
| 邻居表         | 记录所有邻居关系     |
| 链路状态数据库 | 记录所有链路状态信息 |
| 路由表         | 记录最佳路由         |

Router ID：
- 运行OSPF协议前，必须选取的一个RID
- 用来唯一标识一台OSPF路由器（不能重复）
- RID可以手动配置，也可以自动生成
<table>
<colgroup>
<col style="width: 38%" />
<col style="width: 61%" />
</colgroup>
<thead>
<tr class="header">
<th>规则</th>
<th>备注</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p></p>
<p>RID选取规则顺序</p></td>
<td><p>1.优选手动配置</p>
<p>2.活动回环接口中IP地址最大的</p>
<p>3.活动物理接口中IP地址最大的</p></td>
</tr>
</tbody>
</table>
注：任何选举值都未配置是运行不了OSPF的（router id为0.0.0.0）

 比较到物理接口中活动物理接口选取不出来，会选择非活动接口

 RID选举具有非抢占性，修改除非重启OSPF进程

![image6](D:/note/HCIA/resources/2c25ee610ae44ce4a3525614fc468112.jpg)

OSPF数据包的结构和类型：封装基于IP协议，协议号为89

OSPF数据包分为OSPF报头和OSPF数据部分：

![image7](D:/note/HCIA/resources/14eda73d28b34b60b9c497350d01abc3.jpg)

OSPF报头字段是固定的，OSPF数据包的内容由报头的类型决定

![image8](D:/note/HCIA/resources/6d49d79a44584007aa5d505beecb243e.jpg)

![image9](D:/note/HCIA/resources/6c2b333a80fc4cae8cae99b9755f8a3c.jpg)

OSPF数据包的类型：

![image10](D:/note/HCIA/resources/7d7a3d54c80641a58a4816a3e3558847.jpg)

| OSPF数据包                     | 作用                            |
|--------------------------------|---------------------------------|
| Hello                          | 建立并维护邻居关系              |
| Database Description （DD）    | LSDB的摘要信息（仅包含LSA头部） |
| Link State Request（LSR）      | 请求LSA                         |
| Link State Update （LSU）      | 发送LSA （完整的LSA信息）       |
| Link State Acknowledge （LSA） | 对LSU的确认 （OSPF的确认机制）  |

OSPF状态机制：

![image11](D:/note/HCIA/resources/cd8b52817303495ab149ded15d734706.jpg)

| 状态                 | 备注                                |
|----------------------|-------------------------------------|
| 失效状态 Down        | 没有收到Hello包                     |
| 初始状态 Init        | 收到了Hello包，但是邻居列表不存在我 |
| 双向通信状态 2-Way   | 收到了Hell包，且邻居列表存在我      |
| 交换初始状态 Exstart | 决定交互信息时的路由器主从关系      |
| 交互状态 Exchange    | 向邻居发送DD数据包                  |
| 加载状态 Loading     | LSR和LSU和LSA报文交互阶段           |
| 完全邻接状态 Full    | LSDB同步完成，形成邻接关系          |
注：2-Way和Full是稳定状态

OSPF工作流程（数据包和状态切换过程）：

![image12](D:/note/HCIA/resources/f7502f4889af4b719734c6d16ad8ab3e.jpg)
- OSPF第一阶段是使用Hello包建立双向通信的过程，称为邻居关系
![image13](D:/note/HCIA/resources/7251edf3249047c1960967954a9b0e72.jpg)

Exstart：序列号x，I=1表示是第一个发送的DD包，M=1表示后面还有DD包，

MS=1表示我是主（初始都是主）

通过比较Router ID值大的一方为主，向主发送的DD报文中序列号会变成主的序列号，同时这才是真正的DD报文

![image14](D:/note/HCIA/resources/46f410dedc634888b80d65f426edbd3f.jpg)
- OSPF第二阶段是通过交互LSA达到LSDB同步，建立邻接关系

注：确认主从的作用是为了LSDB同步可靠

 同一区域内的路由器中LSDB必须是一致的

OSPF邻居建立条件：必须三层直连

![image15](D:/note/HCIA/resources/f8afbe8181b448b996a78dd3fdab73dc.jpg)

建立邻居需要检验的字段：
- RID不能冲突
- 发送Hello包和邻居失效时间一致
- 区域ID一致
- 认证一致
- 链路MTU大小一致（华为默认不开启，思科默认开启）
- 子网掩码一致、网络地址一致 （以太网组网环境）
- 末梢区域设置一致 （Option字段）

OSPF网络类型：推出时间较早，为了支持不同的链路，而设计了网络类型

OSPF网络类型：广播网络类型（BMA）、点到点网络类型(P2P)、非广播多路访问类型(NBMA)、点到多点网络类型(P2MP)
- 判断网络类型基于接口 （在BMA网络中，每一个网段选取一个DR,BDR）
![image16](D:/note/HCIA/resources/67049926275044a492e838a4149d3a5a.jpg)

![image17](D:/note/HCIA/resources/23c154800a4f46dabe21d4d3f7ea6056.jpg)

| 类型 | 备注 |
|----|----|
| 广播类型 BMA | 通过以太网接口连接设备，支持广播和组播 |
| 点到点P2P | 通过串行接口连接设备，支持广播和组播 |
| 非广播多路访问NBMA | 早期使用帧中继，ATM组网的设备，不支持广播和组播 |
| 点到多点 P2MP | 多个点到点的集合，没有一种链路层协议会被缺省的认为是P2MP类型。点到多点必须是由其他的网络类型强制更改的。 |

DR和BDR：
- 只要是BMA和NBMA网络中，为了减少邻接关系的数量，从而减少数据包的交互次数，最终节省带宽，降低路由器的处理压力
![image18](D:/note/HCIA/resources/faf515c9bd4243b485327a4b9f1e2800.jpg)

<table>
<colgroup>
<col style="width: 15%" />
<col style="width: 84%" />
</colgroup>
<thead>
<tr class="header">
<th>术语</th>
<th>备注</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>DR</td>
<td>Designed Router 指定路由器 ，类似于班长</td>
</tr>
<tr class="even">
<td>BDR</td>
<td>Backup Designed Router 指定备份路由器，DR的备份，类似于副班长</td>
</tr>
<tr class="odd">
<td>DRthers</td>
<td>路由器，类似于普通学生</td>
</tr>
<tr class="even">
<td>关系</td>
<td><p>DR、BDR、DRthers之间都保持邻接关系 （Full）</p>
<p>DRthers之间都保持邻居关系（2-Way）</p></td>
</tr>
<tr class="odd">
<td>地址</td>
<td><p>224.0.0.6向DR和BDR发送 （LSA包）</p>
<p>224.0.0.5向所有OSPF路由器发送 （Hello包）</p></td>
</tr>
<tr class="even">
<td>选举规则</td>
<td><p>首先比较Hello报文中携带的优先级</p>
<p>优先级范围0~255，默认为1</p>
<p>优先级最高的被选举为DR，优先级次高的被选举为BDR</p>
<p>优先级为0不参与选举</p>
<p>优先级一致，比较RID，越大越优先</p>
<p>选举具有非抢占性（选举完成后出现更好的OSPF路由器不会强占角色）</p></td>
</tr>
</tbody>
</table>

LSDB同步过程：

![image19](D:/note/HCIA/resources/f391bc2917ff44f3a2b0905fd5507c24.jpg)

BDR是否收到更新，会发送到224.0.0.5（检测）

![image20](D:/note/HCIA/resources/51dfac6180e24f32af7227fddb8053cd.jpg)

OSPF度量值：Cost 开销
- 在每一个运行OSPF的接口上，都维护着一个接口cost
- cost的计算方式=实际带宽/参考带宽100M （cost最小为1，没有小数）
- 到一个目标网络的度量值=
- 从源到目标的所有出站接口的 Cost值累加（数据方向）
- 从目标到源沿途所有的入站接口的Cost值累计（路由方向）
![image21](D:/note/HCIA/resources/a904f7e8d05e47e381e2d7c2518052bf.jpg)

注：华为的回环口的默认开销是0，思科的回环口默认开销是1

OSPF认证：基于接口区域

![image22](D:/note/HCIA/resources/ecbf2565e5334a51b3c65444dcb10f67.jpg)

![image23](D:/note/HCIA/resources/42aafae31ec84dc58e641ceb166bd790.jpg)

当区域和接口同时配置认证时，接口生效

OSPF配置：
<table>
<colgroup>
<col style="width: 49%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th>命令</th>
<th>备注</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>OSPF 1 router-id 1.1.1.1</td>
<td>开启OSPF，进程号默认为1，手动配置RID</td>
</tr>
<tr class="even">
<td>Area 0/0.0.0.0</td>
<td>配置区域</td>
</tr>
<tr class="odd">
<td>Network 192.168.0.0 0.0.0.255</td>
<td><p>宣告网络，即指定运行OSPF的接口；</p>
<p>使用反掩码来匹配（255.255.255.255）</p></td>
</tr>
<tr class="even">
<td>authentication-mode md5/simple</td>
<td>设置认证，明文或密文</td>
</tr>
<tr class="odd">
<td>Default -route-advertise</td>
<td>发布默认路由</td>
</tr>
<tr class="even">
<td>Display ospf peer （brief）</td>
<td>显示OSPF邻居信息</td>
</tr>
<tr class="odd">
<td>OSPF timer Hello 10</td>
<td>修改Hello包的发送时间</td>
</tr>
<tr class="even">
<td>OSPF timer dead 40</td>
<td>修改Hello包的超时时间</td>
</tr>
<tr class="odd">
<td>Display ospf interface g0/0/0</td>
<td>显示OSPF接口信息</td>
</tr>
<tr class="even">
<td>OSPF dr-priority 10</td>
<td>修改OSPF接口优先级</td>
</tr>
<tr class="odd">
<td>OSPF cost 10</td>
<td>修改开销，范围1~65532</td>
</tr>
<tr class="even">
<td>bandwidth-reference 100</td>
<td><p>修改开销计算的参考值，默认为100M</p>
<p>修改最好在整个OSPF网络中统一修改</p></td>
</tr>
<tr class="odd">
<td>Reset ospf process 1</td>
<td>重启OSPF进程，默认为1</td>
</tr>
<tr class="even">
<td>OSPF 1 enable area 0</td>
<td>在接口开启OSPF功能</td>
</tr>
<tr class="odd">
<td>Ospf authentication-mode MD5/simple</td>
<td>设置认证，接口于区域同时配置，接口生效</td>
</tr>
</tbody>
</table>
