ChinaDNS for OpenWrt
===

简介
---

 本项目是 [ChinaDNS][1] 在 OpenWrt 上的移植  
 当前版本: 1.3.1-1  
 [预编译 IPK 下载][2]  

编译
---

 - 从 OpenWrt 的 [SDK][S] 编译  

   ```bash
   # 以 ar71xx 平台为例
   tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
   cd OpenWrt-SDK-ar71xx-*
   # 获取 Makefile
   git clone https://github.com/aa65535/openwrt-chinadns.git package/chinadns
   # 选择要编译的包 Network -> ChinaDNS
   make menuconfig
   # 开始编译
   make package/chinadns/compile V=99
   ```

配置
---

 - 默认 DNS 服务器端口为 `5353`, 可使用 [LuCI][L] 进行配置  

 - 可搭配路由器自带的 Dnsmasq 使用 借助其 DNS 缓存提升查询速度  

   >LuCI 中定位至「网络 - DHCP/DNS」  
   >「基本设置」 **本地服务器** 填写 `127.0.0.1#5353`  
   >「HOSTS和解析文件」勾选 **忽略解析文件**  

 - [/etc/chinadns_chnroute.txt][3] 可以使用下面命令更新
   ```bash
    wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/chinadns_chnroute.txt
   ```

----------

 Name                     | Description
 -------------------------|-----------------------------------
 [openwrt-dnsmasq][6]     | Dnsmasq Patch & Makefile for OpenWrt
 [openwrt-shadowsocks][7] | Shadowsocks-libev for OpenWrt
 [openwrt-shadowvpn][5]   | ShadowVPN for OpenWrt
 [openwrt-dist-luci][L]   | LuCI Applications for OpenWrt-dist
 [openwrt-redsocks2][R]   | RedSocks2 for OpenWrt


  [1]: https://github.com/clowwindy/ChinaDNS
  [2]: https://sourceforge.net/projects/openwrt-dist/files/chinadns/
  [3]: https://github.com/clowwindy/ChinaDNS/blob/master/chnroute.txt
  [5]: https://github.com/aa65535/openwrt-shadowvpn
  [6]: https://github.com/aa65535/openwrt-dnsmasq
  [7]: https://github.com/shadowsocks/openwrt-shadowsocks
  [R]: https://github.com/aa65535/openwrt-redsocks2
  [S]: http://wiki.openwrt.org/doc/howto/obtain.firmware.sdk
  [L]: https://github.com/aa65535/openwrt-dist-luci
