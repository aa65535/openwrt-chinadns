#
# Copyright (C) 2014 OpenWrt-dist
#
# This is free software, licensed under the MIT.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ChinaDNS-C
PKG_VERSION:=1.1.9
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/aa65535/openwrt-chinadns/releases/download/v$(PKG_VERSION)
PKG_MAINTAINER:=clowwindy <clowwindy42@gmail.com>

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ChinaDNS-C
	SECTION:=net
	CATEGORY:=Network
	TITLE:=ChinaDNS-C
	URL:=https://github.com/clowwindy/ChinaDNS-C
endef

define Package/ChinaDNS-C/description
A DNS forwarder that ignores incorrect(you knew it) responses.
endef

define Package/ChinaDNS-C/conffiles
/etc/config/chinadns
/etc/chinadns_iplist.txt
/etc/chinadns_chnroute.txt
endef

define Package/ChinaDNS-C/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/chinadns.init $(1)/etc/init.d/chinadns
	$(INSTALL_CONF) ./files/chinadns.list $(1)/etc/chinadns_iplist.txt
	$(INSTALL_CONF) ./files/chinadns.route $(1)/etc/chinadns_chnroute.txt
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/chinadns.config $(1)/etc/config/chinadns
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/chinadns $(1)/usr/bin
endef

$(eval $(call BuildPackage,ChinaDNS-C))
