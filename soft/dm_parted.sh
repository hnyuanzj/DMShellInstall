#!/bin/bash
#1.上传parted.sh脚本到家目录
#2.授予parted.sh执行权限：chmod 775 parted.sh
#3.执行脚本分区挂载磁盘：./parted.sh
#注意：如果数据库盘是sdb，直接执行，如果数据盘是vdb，请修改脚本sdb为vdb，使用notepad++修改即可

#1.挂载磁盘
# 1---parted /dev/sdb p
parted /dev/sdb <<EOF
mklabel gpt
mkpart dmdata 0% 65%
mkpart dmarch 65% 75%
mkpart dmbak  75% 100%
p             
q
EOF

# 2---df -Th
for ((i = 1; i <= 3; i++)); do
    /usr/sbin/mkfs.ext4 -T largefile /dev/sdb$i
done

mkdir /opt/dmdbms
mkdir -p /dm{data,arch,bak}

# 3---cat /etc/fstab
uuid1=$(blkid | grep sdb1 | awk '{print $2}' | cut -c 7-42)
echo "UUID=$uuid1 /dmdata ext4 defaults,noatime 0 0" >>/etc/fstab
uuid2=$(blkid | grep sdb2 | awk '{print $2}' | cut -c 7-42)
echo "UUID=$uuid2 /dmarch ext4 defaults,noatime 0 0" >>/etc/fstab
uuid3=$(blkid | grep sdb3 | awk '{print $2}' | cut -c 7-42)
echo "UUID=$uuid3 /dmbak ext4 defaults,noatime 0 0" >>/etc/fstab
mount -a

# 4----df  -h
df -h
