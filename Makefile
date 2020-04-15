#
# Copyright (C) 2014-2018 OpenWrt-dist
# Copyright (C) 2014-2020 Jian Chang <aa65535@live.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ChinaDNS
PKG_VERSION:=1.3.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/aa65535/ChinaDNS.git
PKG_SOURCE_VERSION:=00616680114011553881760e843b77a3519e8fbf
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jian Chang <aa65535@live.com>

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/ChinaDNS
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Protect yourself against DNS poisoning in China.
	URL:=https://github.com/shadowsocks/ChinaDNS
endef

define Package/ChinaDNS/description
Protect yourself against DNS poisoning in China.
endef

define Package/ChinaDNS/conffiles
/etc/config/chinadns
/etc/chinadns_chnroute.txt
endef

define Package/ChinaDNS/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/chinadns $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) files/chinadns.init $(1)/etc/init.d/chinadns
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) files/chinadns.config $(1)/etc/config/chinadns
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/chnroute.txt $(1)/etc/chinadns_chnroute.txt
endef

$(eval $(call BuildPackage,ChinaDNS))
