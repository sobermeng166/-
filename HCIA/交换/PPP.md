![image1](D:/note/HCIA/resources/b6c116fd59ef40d6b6f0e4c655355d43.jpg)

![image2](D:/note/HCIA/resources/654c22bc61244abe9a90e372c21cc358.jpg)

![image3](D:/note/HCIA/resources/cf0f538e943c492fa6671ca0c6801da7.jpg)

![image4](D:/note/HCIA/resources/b7ceb1148f774b4dbcf5b5008c184c0a.jpg)
- 可以借用接口地址来节省IP地址

![image5](D:/note/HCIA/resources/95c8d98c42b74798b2c41f0ffc881570.jpg)

![image6](D:/note/HCIA/resources/79aacd4cb31749f497e89ea6f19c4469.jpg)

| 名称 | 认证 | 错误检测 | 错误恢复 | 支持同步或异步链路 |
|------|------|----------|----------|--------------------|
| HDLC | ×    | √        | ×        | ×                  |
| PPP  | √    | √        | √        | √                  |

![image7](D:/note/HCIA/resources/4b9c580e2d8c4e84881f736b837e30e6.jpg)

![image8](D:/note/HCIA/resources/4f451050761c4964a8ca6eb4f8ae9540.jpg)

PPP认证模式：PAP和CHAP

| 模式                                                | 备注                                                         |
| --------------------------------------------------- | ------------------------------------------------------------ |
| PAP（Password authentication protocol）             | 密码认证协议：以明文方式直接放送密码，二次握手机制，发送方为被认证方<br/>缺点：以明文的形式发送密码不安全 |
| CHAP（Challenge Handshake Authentication Protocol） | 挑战/质询握手认证协议：以MD5来隐藏密码，三层握手机制，由认证方发起认证，有效避免了暴力破解，在链路建立后具有再次认证检测机制，目前使用的广泛 |

![image9](D:/note/HCIA/resources/280bb842b71341e0bb2a79e3177cffc3.jpg)

![image10](D:/note/HCIA/resources/0b280d42111b4f5985a27a14a172d200.jpg)

![image11](D:/note/HCIA/resources/76c2cfd5e3744166b72beaa317fff8cf.jpg)

![image12](D:/note/HCIA/resources/98b0411f7f8148ceb21b3d26d60bf011.jpg)

PPP认证配置：

**命令：**

```
AAA
local-user huawei password 123.com
local-user huawei service-type PPP
##配置PPP，设置用户名密码和服务类型

PPP authentication-mode PAP/CHAP  ## 配置认证模式

PPP pap local-user huawei password cipher 123.com  ## 配置PAP认证

PPP chap user huawei
PPP chap password cipher 123.com
## 配置CHAP认证
```

