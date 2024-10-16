![image1](D:/note/HCIA/resources/3b6b31a573394b5fbcf66570d9337582.jpg)

公网地址的由来：

个人/企业——/>ISP运营商——/>CNNIC中国互联网络信息中心——/>APNIC（Asia Pacific Network Information Centre）亚太地址网络信息中心——/>IANA互联网数字分配机构 （早在2012年IP地址就已经分配完了）

![image2](D:/note/HCIA/resources/c7b7e4e94aab4834b1b7acf6ca4c3451.jpg)

没有NAT技术，私网地址数据可以出去，但是回不来（无回程路由）

![image3](D:/note/HCIA/resources/f19e1805f35a4f5991b1054d1c385dfa.jpg)

![image4](D:/note/HCIA/resources/95fc7104fe1741a2b44d8c231e2fc650.jpg)

私网地址不可能出现在公网上（太多私网地址重复，设备性能也不足以支持）

NAT地址转换缓存表：记录转换地址信息

![image5](D:/note/HCIA/resources/d64ac9cd0b164b43a9d55d7232c1ca05.jpg)

NAT好处：
- 有效避免了来自外网的攻击，大大提高了网络安全性
- 控制内外访问外网，同时也控制外网访问内网，解决了内网和外网通信的问题

家庭路由器和运营商路由器的区别：1.记录NAT缓存需要消耗大量的内存，CPU，导致上网速度慢（待机数量）

 2.带宽和包转发

NAT类型：NAT的实现方式有很多种，适用于不同的场景

![image6](D:/note/HCIA/resources/684ddfc239c649cbb9dfc83cb32a177e.jpg)
- 如果希望一台主机专用某个公网地址，或者想要外网访问内网服务器时，可以使用静态NAT
- 静态NAT不能有效缓解公网地址短缺的问题

| 命令                                        | 备注              |
|---------------------------------------------|-------------------|
| Nat static enable                           | 开启NAT静态功能   |
| Nat static global 公网地址 inside 私网地址 | 创建映射关系      |
| Display nat static                          | 验证静态NAT的配置 |

![image7](D:/note/HCIA/resources/23e9ada82e2741aeb84fb47879a12efa.jpg)
- 动态NAT定义了地址池，规定一个范围的地址可以供主机转换
- 动态NAT地址池中的地址用尽后，只能等待被占用的地址被释放，其他主机才能使用它来访问公网
- 动态NAT也不能有效缓解公网地址短缺的问题

（使用ICMP时地址会变换，是没有端口的，但是有标识，可以根据标识来分辨）

![image8](D:/note/HCIA/resources/bffac4d0ca374a89aa94975baa758ed0.jpg)
- NAPT（network address port translation）也成为NAT-PT或PAT 网络地址端口转换
- 通常适用于大型企业网络（申请多个固定的公网地址）
- NAPT需要定义地址池，不能直接使用出接口的地址
- 有效的缓解了公网地址短缺的问题

| 命令                                            | 备注                  |
|-------------------------------------------------|-----------------------|
| Nat address-group 编号 公网地址范围             | 配置NAT地址池         |
| Nat outbound acl 编号 address-group 编号 no-pat | 配置调用ACL关联地址池 |
| Nat outbound acl 编号 address-group 编号        | 配置NAPT              |
| Display nat address-group                       | 验证NAT地址池配置信息 |
| Display nat outbound                            | 验证动态NAT配置信息   |

![image9](D:/note/HCIA/resources/dac1864ada7e443c826205eaff3a658b.jpg)
- 直接使用出接口的地址做转换
- Easy IP适用于小规模居于网中的主机访问Internet的场景
- 如：家庭、小型网吧、小型办公室中，这些地方内部主机不多，出接口可以通过拨号方式获取一个临时公网IP地址
- 有效的缓解了公网地址紧缺和不固定的公网地址转换问题

| 命令                  | 备注                          |
|-----------------------|-------------------------------|
| Nat outbound acl 编号 | 配置Easy IP 关联出站接口和ACL |

能够实现外网地址访问内网地址的方法：NAT、VPN

![image10](D:/note/HCIA/resources/981ac6922b874bfeba2e7e6befb166fc.jpg)
- NAT具有“屏蔽”内部主机的作用，但有时内网需要向外网提供服务
- 当外网用户访问内网服务器时，出口设备通过事先配置好的“公网IP地址+端口号”与“私网IP地址+端口号”间的映射关系，将服务器的“公网IP地址和端口号”根据映射关系替换成对应的“私网IP地址+端口号”
- NAT服务器的公网IP地址和端口中，端口可以更改，提供安全性

| 命令 | 备注 |
|----|----|
| Nat server protocol tcp/udp global/current-interface 端口 inside 私网地址 端口 | 配置NAT服务器 |
| Display nat server | 验证NAT服务器 |
