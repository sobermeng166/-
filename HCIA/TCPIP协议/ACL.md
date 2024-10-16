ACL：Access Control List 访问控制列表 （第一代防火墙）

![image2](D:/note/HCIA/resources/7e81a979f9454fe88fda525d29246777.jpg)

![image3](D:/note/HCIA/resources/2adb86d448004b55b5e915f2915682dd.jpg)

ACL工作原理：

![image4](D:/note/HCIA/resources/ea0bd4f786d04cfab1db82d43d7c3ba3.jpg)
- ACL由一条或多条规则组成
- 每条规则必须选择动作：允许permit或拒绝deny
- 每条规则都会一个id序列号（缺省值为5，步长默认为5）
- 序列号越小越先进行匹配
- 只要有一条规则和报文匹配，就停止查找，称为命中规则
- 查找完所有规则，如果没有符合条件的规则，称为未命中规则
- ACL只是一个流量匹配工具，需要应用在实际的接口或其他技术内才会激活
- 应用在接口时必须选择方向：入站或出站
- 不能过滤由设备自己产生的流量

![image5](D:/note/HCIA/resources/add310dfcb4540c98887932908fddd95.jpg)

ACL类型：分为数字型ACL和命名ACL

数字型ACL：下列序号是比较熟悉的，对于高级的设备支持匹配的序号越多
| 分类    | 编号范围  | 参数                                     |
|---------|-----------|------------------------------------------|
| 基本ACL | 2000~2999 | 源IP地址等                              |
| 高级ACL | 3000~3999 | 源IP地址、目标IP地址、源端口、目标端口等 |
| 二层ACL | 4000~4999 | 源MAC地址、目标MAC地址、以太网帧类型等   |

命名型ACL：可用根据自己需求来选择数字型ACL的序号

正掩码、反掩码、通配符区别：
| 名称   | 规则       | 作用     | 举例          | 备注                     |
|--------|------------|----------|---------------|--------------------------|
| 掩码   | 连续的1和0 | IP地址   | 255.255.255.0 | 1对应网络位，0对应主机位 |
| 反掩码 | 连续的1和0 | 路由协议 | 0.0.0.255     | 0必须匹配，1无须匹配     |
| 通配符 | 任意的1和0 | ACL      | 0.0.255.0     | 0必须匹配，1无须匹配     |

| 举例                    | 备注               |
|-------------------------|--------------------|
| 192.168.0.1 0.0.0.0     | 匹配一个主机地址   |
| 192.168.0.0 0.0.0.255   | 匹配一个网段       |
| 192.168.0.1 0.0.0.254   | 匹配网段内奇数地址 |
| 192.168.0.0 0.0.0.254   | 匹配网段内偶数地址 |
| x.x.x.x 255.255.255.255 | 匹配所有地址       |

![image6](D:/note/HCIA/resources/25d5493cd99d42ca91624f8336923345.jpg)

![image7](D:/note/HCIA/resources/69805abde1f1472fbe97e1ec28089380.jpg)

ACL调用方向建议：

1.基本ACL尽量调用在离目标最近的出站接口Outbound

2.高级ACL尽量调用在离源头最近的入站接口Inbound

3.ACL的规则一般是先细后粗

![image8](D:/note/HCIA/resources/de5e59d0bc4a4718aabea4c2febe108d.jpg)

ACL配置：
<table>
<colgroup>
<col style="width: 55%" />
<col style="width: 44%" />
</colgroup>
<thead>
<tr class="header">
<th>命令</th>
<th>配置</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Acl 2000</td>
<td>创建一个基本ACL</td>
</tr>
<tr class="even">
<td>Rule 5 permit/deny source 192.168.1.0 0.0.0.255</td>
<td>配置ACL的规则：允许或拒绝源地址为192.168.1.0网段内的所有流量</td>
</tr>
<tr class="odd">
<td>Acl 3000</td>
<td>创建一个高级ACL</td>
</tr>
<tr class="even">
<td><p>Rule 5 permit/deny tcp source 192.168.1.0 0.0.0.255 destination 8.8.8.8 0 destination-port eq 80</p>
<p> eq 等于</p>
<p> gt 大于</p>
<p> lt 小于</p>
<p> range 范围</p></td>
<td>配置ACL的规则：允许或拒绝源地址192.168.1.0网段内所有流量去访问8.8.8.8的80端口</td>
</tr>
<tr class="odd">
<td>traffic-filter inbound/outbound acl 2000</td>
<td>在接口调用下，出去的流量/进来的流量中匹配ACL2000</td>
</tr>
<tr class="even">
<td>Display acl 2000</td>
<td>验证ACL2000</td>
</tr>
<tr class="odd">
<td>Display traffic-filter applied-record</td>
<td>查看设备上所有基于ACL调用情况</td>
</tr>
</tbody>
</table>
