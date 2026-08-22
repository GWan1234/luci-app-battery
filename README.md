# luci-app-battery

LuCI 插件：在「状态 → 概览」页面显示设备电池电量与充电状态。

## 功能
- 在 LuCI 状态概览页（admin/status/overview）顶部追加 Battery 信息区块
- 显示电量百分比（进度条）与充电中/放电中状态标签
- 区块自动轮询刷新、可折叠（由 LuCI 概览页 include 机制提供）
- 零侵入：不改动任何官方 LuCI 源码，卸载即复原

## 原理
LuCI2 概览页（luci-mod-status 的 view/status/index.js）会自动扫描并加载
/www/luci-static/resources/view/status/include/*.js，每个文件渲染为一个信息区块。
本插件在该目录放置 05_battery.js 实现附加显示；数据由 ucode rpcd 后端
（/usr/share/rpcd/ucode/luci.battery）读取内核 power_supply 子系统：
- /sys/class/power_supply/battery/capacity
- /sys/class/power_supply/battery/status
- /sys/class/power_supply/charger/online

## 兼容性
- 内核需在 /sys/class/power_supply/ 暴露 battery 与 charger
- 适用于 OpenWrt 24.10 / iStoreOS 等使用新版 LuCI（LuCI2）的固件

## 构建
将本目录通过 src-link 接入 OpenWrt 构建树（feeds.conf.default 追加）：
    src-link battery /path/to/luci-app-battery
然后：
    ./scripts/feeds update battery
    ./scripts/feeds install -a -p battery
    make package/luci-app-battery/compile

产物：bin/packages/<arch>/battery/luci-app-battery_1.0-r1_all.ipk

## 安装
    opkg install luci-app-battery_1.0-r1_all.ipk
卸载：
    opkg remove luci-app-battery

## License
Apache-2.0
