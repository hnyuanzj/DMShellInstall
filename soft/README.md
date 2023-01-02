# 更新记录
- `2022/11/03`
	- 创建 DMShellInstall 脚本
- `2022/11/12`
	- 补充功能，优化脚本输出
- `2022/11/13`
	- 补充功能，增加传参判断
- `2022/11/20`
	- 修复BUG，增加参数
- `2022/11/22`
	- 增加数据守护模式安装1主1备
- `2022/11/23`
	- 增加数据守护1主2备/3备
- `2022/11/25`
	- 增加数据守护支持1主8备
- `2022/11/26`
	- 兼容 Linux 6 版本
- `2022/12/12`
	- 增加 dsc 部署功能
- `2022/12/13`
	- 增加 dsc 多链路聚合磁盘部署
- `2022/12/15`
	- 增加 dsc 自定义db_name和ep_name
- `2022/12/17`
	- 优化 dsc 脚本参数和逻辑
- `2022/12/21`
	- 内置最新的达梦数据库优化脚本，增加新的参数-sm --sort_mode 参数
- `2022/12/23`
	- 适配复杂密码，除了 & ' " ()  四种字符外，可以输入任意字符
- `2022/12/28`
	- 适配单链路单盘多分区，聚合链路单盘多分区部署dsc（只能在linux7以上版本服务器使用）
- `2023/01/02`
	- 删除"-dhn" "--wc_hostname" 参数，保留"-hn" "--hostname" 参数， 集群时是主机名前缀，例如 -hn db，每个节点主机名是db01,db02..."

# 参数介绍
关于脚本的参数使用可执行 `./DMShellInstall -h` 进行查看。
## 单机参数
单实例数据库无需任何参数即可安装。

|参数缩写|参数用途|参数默认值|是否必填|
|--|--|--|:--:|
|-hn |主机名|dmdb|×|
|-dp |系统用户dmdb密码|Dameng@123|×|
|-d  |数据库软件安装目录|/dm|×|
|-dd |数据库文件目录|/dmdata|×|
|-ad |数据库归档目录|/dmarch|×|
|-bd |数据库备份目录|/dmbak|×|
|-dn |数据库名称|DAMENG|×|
|-in |数据库实例名称|DMSERVER|×|
|-es |数据文件簇大小|32|×|
|-ps |数据页大小|32|×|
|-cs |字符串大小写敏感|Y|×|
|-c  |数据库字符集|1|×|
|-lic|VARCHAR类型长度是否以字符为单位|N|×|
|-ls|日志文件大小，单位M|1024|×|
|-er|是否开启归档模式|Y|×|
|-sl|归档空间大小，单位M|102400|×|
|-pn |监听端口号|5236|×|
|-sp |数据库SYSDBA用户密码|SYSDBA|×|
|-bm |数据库备份模式|1|×|
|-ti |时间服务器IP地址|×|
|-m|仅配置操作系统，不安装达梦软件以及数据库|N|×|
|-ud|仅安装达梦数据库软件，不创建数据库|N|×|
|-oid|仅初始化数据库|N|×|
|-opd|建库后自动优化数据库|N|×|
|-oopd|脚本仅优化数据库|N|×|
|-mp|优化数据库时物理内存占比|80|×|
|-sm|并发量较高的OLTP数据库，参数 [0]，并发量不高的一般业务系统和OLAP类的系统参数值 [1]|0|×|
|-di|达梦安装镜像名称||×|
|-kp|达梦数据库密钥路径||×|

## 数据守护参数
数据守护安装最多支持1主8备，需要所有节点挂载 ISO 用来配置 YUM 源，所有节点的 root 密码保持一致。

|参数缩写|参数用途|参数默认值|是否必填|
|--|--|--|:--:|
|-rp|root用户密码||√|
|-hn|各节点主机名前缀||×|
|-dpi|主备业务IP||√|
|-dmi|主备MAL IP||√|
|-dmoi|监视器主机 IP||√|
|-dgn|数据守护组名|GRP1|×|
|-mpn|MAL 监听端口号,取值范围：1024~65535|5336|×|
|-mdpn|守护进程端口号,取值范围：1024~65535|5436|×|
|-midpn|实例监听守护进程端口号,取值范围：1024~65535|5536|×|
|-oi|是否需要挂载操作系统 ISO 镜像，脚本自动配置 YUM 源|Y|×|

DSC参数
DSC安装脚本最多支持8个节点，需要所有节点挂载 ISO 用来配置 YUM 源，所有节点的 root 密码保持一致。

|参数缩写|参数用途|参数默认值|是否必填|
|--|--|--|:--:|
-rp |root 用户密码||√|                                
-hn|各节点主机名前缀||×|
-dpi|各节点业务IP||√|
-dmi|各节点MAL IP||√|
-ddn|数据库DB_NAME|DSC|x|                
-den|数据库每个节点的实例名前缀|DSC|x|
-dcd|dcr磁盘名字|×|√|
-vod|vote磁盘名字|×|√|
-lod|redo日志磁盘|×|×|
-ard|归档日志磁盘|×|×|
-dad|数据盘|×|√|
-apd|asm实例密码|Welcome1|×|
-cdp|css通信端口,取值范围：1024~65534|9341|×|
-adp|asm通信端口,取值范围：1024~65534|9351|×|
-ddp|db通信端口,取值范围：1024~65534|9741|×|
-amp|mal系统通信端口,取值范围：1024~65534|7236|x|
-mtp|是否需要配置multipath多链路聚合，脚本默认不配置|N|×|
-oi |是否需要挂载操作系统 ISO 镜像，脚本自动配置 YUM 源 |Y|×|


**注意：** 达梦数据库安装以及初始化相关参数，请参考单机安装参数，两者共用。

# 脚本使用
## 单机安装
使用脚本前：
- 安装好干净的 Linux 操作系统（redhat/linux/centos/麒麟）
- 配置好网络（规划 IP 地址）
- 配置好存储（规划存储）
- 解压达梦安装包，将ISO移动到与脚本一个目录下，并指定参数 -di iso镜像名称 

以下提供常用安装命令，可根据实际情况进行增删。
### 仅配置操作系统
```bash
./DMShellInstall -hn dmdb `# 主机名`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-ad /dmarch `# 数据库归档目录`\
-bd /dmbak `# 数据库备份目录`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`\
-m Y `# 仅配置操作系统`
```
### 安装软件不建库
```bash
./DMShellInstall -hn dmdb `# 主机名`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-ad /dmarch `# 数据库归档目录`\
-bd /dmbak `# 数据库备份目录`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`\
-ud Y `# 仅安装达梦数据库软件`
```
### 最简化测试环境部署
```bash
./DMShellInstall -di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 生产环境安装部署
```bash
./DMShellInstall -hn dmdb `# 主机名`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-ad /dmarch `# 数据库归档目录`\
-bd /dmbak `# 数据库备份目录`\
-dn DAMENG `# 数据库名称`\
-in DMSERVER `#实例名称`\
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 仅初始化数据库实例
```bash
./DMShellInstall -dd /dmdata `# 数据库文件目录`\
-dn DAMENG `# 数据库名称`\
-in DMSERVER `#实例名称`\
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-oid Y `# 仅初始化数据库`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`
```
### 脚本仅优化数据库
```bash
./DMShellInstall -sp SYSDBA `# 数据库SYSDBA用户密码`\
-in DMSERVER `#实例名称`\
-oopd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`
```

## 数据守护和DSC安装
使用脚本前：
- 主备节点均安装好干净的 Linux 操作系统（redhat/linux/centos/麒麟）
- 主备节点均配置好网络（规划业务 IP /MAL IP地址）
- 主备节点均配置好存储（规划存储）
- 主备节点均挂载操作系统 ISO 镜像
- 主节点解压达梦安装包，将ISO移动到与脚本一个目录下，并指定参数 -di iso 镜像名称 

以下提供常用安装命令，可根据实际情况进行增删。

### 一主一备
```bash
./DMShellInstall -hn dw `# 主备主机名前缀`\
-dpi 10.211.55.101,10.211.55.102 `# 主备业务IP`\
-dmi 1.1.1.1,1.1.1.2 `# 主备MAL IP`\
-dgn GRP1 `# 数据守护组名`\
-mpn 5336 `# MAL 监听端口`\
-mdpn 5436 `# 守护进程端口号`\
-midpn 5536 `# 实例监听守护进程端口号`\
-rp P@ssw0rdPST `# 主备 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-ad /dmarch `# 数据库归档目录`\
-bd /dmbak `# 数据库备份目录`\
-dn DAMENG `# 数据库名称`\
-in DMSERVER `#实例名称`\
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```

### 一主两备
```bash
./DMShellInstall -hn dw `# 主备主机名前缀`\
-dpi 10.211.55.101,10.211.55.102,10.211.55.103 `# 主备业务IP`\
-dmi 1.1.1.1,1.1.1.2,1.1.1.3 `# 主备MAL IP`\
-dgn GRP1 `# 数据守护组名`\
-mpn 5336 `# MAL 监听端口`\
-mdpn 5436 `# 守护进程端口号`\
-midpn 5536 `# 实例监听守护进程端口号`\
-rp P@ssw0rdPST `# 主备 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-ad /dmarch `# 数据库归档目录`\
-bd /dmbak `# 数据库备份目录`\
-dn DAMENG `# 数据库名称`\
-in DMSERVER `#实例名称`\
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```

### 一主三备
```bash
./DMShellInstall -hn dw `# 主备主机名前缀`\
-dpi 10.211.55.101,10.211.55.102,10.211.55.103,10.211.55.104 `# 主备业务IP`\
-dmi 1.1.1.1,1.1.1.2,1.1.1.3,1.1.1.4 `# 主备MAL IP`\
-dgn GRP1 `# 数据守护组名`\
-mpn 5336 `# MAL 监听端口`\
-mdpn 5436 `# 守护进程端口号`\
-midpn 5536 `# 实例监听守护进程端口号`\
-rp P@ssw0rdPST `# 主备 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-ad /dmarch `# 数据库归档目录`\
-bd /dmbak `# 数据库备份目录`\
-dn DAMENG `# 数据库名称`\
-in DMSERVER `#实例名称`\
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```

### 一主一备一监视
```bash
./DMShellInstall -hn dw `# 主备主机名前缀`\
-dpi 10.211.55.101,10.211.55.102 `# 主备业务IP`\
-dmi 1.1.1.1,1.1.1.2 `# 主备MAL IP`\
-dmoi 10.211.55.103 `# 监视器主机 IP`\
-dgn GRP1 `# 数据守护组名`\
-mpn 5336 `# MAL 监听端口`\
-mdpn 5436 `# 守护进程端口号`\
-midpn 5536 `# 实例监听守护进程端口号`\
-rp P@ssw0rdPST `# 主备 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-ad /dmarch `# 数据库归档目录`\
-bd /dmbak `# 数据库备份目录`\
-dn DAMENG `# 数据库名称`\
-in DMSERVER `#实例名称`\
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```

## 两节点 dsc

### 磁盘分区：dcr vote data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102 `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-data /dev/sde,/dev/sdf,/dev/sdg ` #数据盘，此时默认redo日志和归档与数据文件在一起`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `# asm实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 磁盘分区：dcr vote arch data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102 `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-ard /dev/sde `# 归档日志磁盘`\
-dad /dev/sdf,/dev/sdg `# 数据盘，此时默认redo日志与数据文件在一起`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `# asm实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 磁盘分区：dcr vote log data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102 `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-lod /dev/sde `# redo日志磁盘`\
-dad /dev/sdf,/dev/sdg `#数据盘，此时默认归档日志与数据文件在一起`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `#asm 实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 磁盘分区：dcr vote arch log data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102 `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-ard /dev/sde `# 归档日志磁盘`\
-lod /dev/sdf `# redo日志磁盘`\
-dad /dev/sdg `# 数据盘`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `# asm实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```

## 三节点 dsc

### 磁盘分区：dcr vote data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102,10.211.55.103 `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2,1.1.1.3 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-data /dev/sde,/dev/sdf,/dev/sdg `#数据盘，此时默认redo日志和归档与数据文件在一起`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `# asm实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 磁盘分区：dcr vote arch data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102,10.211.55.103  `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2,1.1.1.3 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-ard /dev/sde `# 归档日志磁盘`\
-dad /dev/sdf,/dev/sdg `#数据盘，此时默认redo日志与数据文件在一起`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `# asm实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 磁盘分区：dcr vote log data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102,10.211.55.103  `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2,1.1.1.3 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-lod /dev/sde `# redo日志磁盘`\
-dad /dev/sdf,/dev/sdg `#数据盘，此时默认归档日志与数据文件在一起`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `# asm实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
### 磁盘分区：dcr vote arch log data
```bash
./DMShellInstall -hn dsc `# dsc主机名前缀`\
-dpi 10.211.55.101,10.211.55.102,10.211.55.103  `# dsc业务IP`\
-dmi 1.1.1.1,1.1.1.2,1.1.1.3 `# 各节点MAL IP`\
-dcd /dev/sdc `# dcr磁盘`\
-vod /dev/sdd `# vote磁盘`\
-ard /dev/sde `# 归档日志磁盘`\
-lod /dev/sdf `# redo日志磁盘`\
-dad /dev/sdg #`数据盘`\
-cdp 12345 `# css通信端口号`\
-adp 12346 `# asm通信端口号`\
-ddp 12347 `# 实例通信端口号`\
-amp 8888  `# mal系统通信端口`\
-rp P@ssw0rdPST `# 服务器 root 用户密码`\
-dp Dameng@123 `# dmdba用户密码`\
-d /dm `# 软件安装目录`\
-dd /dmdata `# 数据库文件目录`\
-bd /dmbak `# 数据库备份目录`\
-apd Welcome1 `# asm实例密码`
-es 32 `# 数据文件簇大小`\
-ps 32 `# 数据页大小`\
-cs Y `# 字符串大小写敏感`\
-c 1 `# 数据库字符集`\
-lic N `# VARCHAR类型长度是否以字符为单位`\
-sl 10240 `# 归档空间大小`\
-pn 5236 `# 监听端口号`\
-sp SYSDBA `# 数据库SYSDBA用户密码`\
-bm 2 `# 数据库备份模式 1全备 2增量`\
-opd Y `# 优化数据库参数`\
-mp 80 `# 优化数据库物理内存占比`\
-di dm8_20221008_x86_rh6_64.iso `# 达梦ISO镜像名称`
```
