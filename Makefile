include $(TOPDIR)/rules.mk

PKG_NAME:=ChinaDNS-C
PKG_VERSION:=1.1.6
PKG_SHA:=cff180742f80266ee3338dfe3b6c2c5eb5b3402f

PKG_SOURCE:=$(PKG_SHA).zip
PKG_SOURCE_URL:=https://github.com/clowwindy/ChinaDNS-C/archive
PKG_CAT:=unzip

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=COPYING

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_NAME)-$(PKG_SHA)

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
A DNS forwarder that filters bad IPs.
endef

define Package/ChinaDNS-C/conffiles
/etc/chinadns_iplist.txt
/etc/chinadns_chnroute.txt
endef

define Package/ChinaDNS-C/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/chinadns.init $(1)/etc/init.d/chinadns
	$(INSTALL_CONF) ./files/chinadns.list $(1)/etc/chinadns_iplist.txt
	$(INSTALL_CONF) ./files/chinadns.route $(1)/etc/chinadns_chnroute.txt
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/chinadns $(1)/usr/bin
endef

$(eval $(call BuildPackage,ChinaDNS-C))
