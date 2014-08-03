OpenWrt's ChinaDNS-C Makefile
===

 > 编译时默认从 [ChinaDNS-C][1] 下载最新源码

编译说明
---

 - OpenWrt 平台的编译, [预编译 IPK 下载][2]

   ```
   # 获取 Makefile
   git clone https://github.com/aa65535/openwrt-chinadns.git package/network/chinadns
   # 选择要编译的包 Network -> ChinaDNS-C
   make menuconfig
   # 开始编译 ChinaDNS-C
   rm -f dl/master.zip && make package/network/chinadns/compile V=99
   # 若上面语句编译出错 使用下面语句编译
   make V=99
   ```

配置说明
---

 - 预设 DNS 服务器 `114.114.114.114,8.8.4.4` 可编辑 `/etc/init.d/chinadns` 修改

 - Bad IP 列表 `/etc/chinadns_iplist.txt`

 - 搭配路由器自带的 Dnsmasq 使用 借助其 DNS 缓存提升查询速度 配置如下
   ```
   no-resolv
   no-negcache
   server=127.0.0.1#5353
   ```


  [1]: https://github.com/clowwindy/ChinaDNS-C
  [2]: https://sourceforge.net/projects/openwrt-dist/files/chinadns-c/
