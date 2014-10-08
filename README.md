OpenWrt's ChinaDNS-C Makefile
===

 > 编译时默认从 [clowwindy/ChinaDNS-C][1] 下载最新源码

编译说明
---

 - 从 OpenWrt 的 [SDK][S] 编译, [预编译 IPK 下载][2]

 > ```bash
 > # 以 ar71xx 平台为例
 > tar xjf OpenWrt-SDK-ar71xx-for-linux-x86_64-gcc-4.8-linaro_uClibc-0.9.33.2.tar.bz2
 > cd OpenWrt-SDK-ar71xx-*
 > # 获取 Makefile
 > git clone https://github.com/aa65535/openwrt-chinadns.git package/chinadns-c
 > # 选择要编译的包 Network -> ChinaDNS-C
 > make menuconfig
 > # 开始编译
 > make package/chinadns-c/compile V=99
 > ```

配置说明
---

 - 默认 DNS 服务器为 `127.0.0.1` 端口 `53`

 - 可搭配路由器自带的 Dnsmasq 使用 借助其 DNS 缓存提升查询速度

 > 将 `/etc/init.d/chinadns` 中两条 `iptables` 命令注释或者删除
 >
 > 修改 Dnsmasq 配置`(/etc/dnsmasq.conf)`如下
 > ```cfg
 > no-resolv
 > server=127.0.0.1#5353
 > ```
 > 并删除其他 `server=` 项

 - [chnroute][3] 可以使用下面命令更新
    > ```bash
    > wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/chinadns_chnroute.txt
    > ```

相关项目
---

 Name                     | Description
 -------------------------|-----------------------------------
 [openwrt-dnsmasq][6]     | OpenWrt's Dnsmasq Patch & Makefile
 [openwrt-shadowsocks][7] | OpenWrt's ShadowSocks Makefile
 [openwrt-shadowvpn][5]   | OpenWrt's ShadowVPN Makefile


  [1]: https://github.com/clowwindy/ChinaDNS-C
  [2]: https://sourceforge.net/projects/openwrt-dist/files/chinadns-c/
  [3]: https://github.com/aa65535/openwrt-chinadns/blob/master/files/chinadns.route
  [5]: https://github.com/aa65535/openwrt-shadowvpn
  [6]: https://github.com/aa65535/openwrt-dnsmasq
  [7]: https://github.com/aa65535/openwrt-shadowsocks
  [S]: http://downloads.openwrt.org/snapshots/trunk/
