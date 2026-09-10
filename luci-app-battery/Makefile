include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-battery
PKG_VERSION:=1.0
PKG_RELEASE:=3
PKG_LICENSE:=Apache-2.0

include $(INCLUDE_DIR)/package.mk

define Build/Compile
endef

define Package/luci-app-battery
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=LuCI battery status on overview page
  DEPENDS:=+luci-base +rpcd-mod-ucode +luci-mod-status
  PKGARCH:=all
endef

define Package/luci-app-battery/description
	Displays battery charge level and charging status from /sys/class/power_supply on the LuCI status overview page.
endef

define Package/luci-app-battery/install
	$(INSTALL_DIR) $(1)/www/luci-static/resources/view/status/include
	$(INSTALL_DATA) ./htdocs/luci-static/resources/view/status/include/05_battery.js $(1)/www/luci-static/resources/view/status/include/
	$(INSTALL_DIR) $(1)/usr/share/rpcd/ucode
	$(INSTALL_DATA) ./root/usr/share/rpcd/ucode/luci.battery.uc $(1)/usr/share/rpcd/ucode/
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DATA) ./root/usr/share/rpcd/acl.d/luci-app-battery.json $(1)/usr/share/rpcd/acl.d/
endef

define Package/luci-app-battery/postinst
#!/bin/sh
rm -f /tmp/luci-modulecache /tmp/luci-indexcache.*
/etc/init.d/rpcd reload 2>/dev/null || true
exit 0
endef

define Package/luci-app-battery/postrm
#!/bin/sh
rm -f /tmp/luci-modulecache /tmp/luci-indexcache.*
exit 0
endef

$(eval $(call BuildPackage,luci-app-battery))
