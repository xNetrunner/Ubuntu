# 1 VM

# Установка
apt-get update
apt install nfs-kernel-server nfs-common -y

# Настройка и запуск
mkdir -p /srv/shares/nfs
chown ${USER}:${USER} -R /srv/shares/nfs/
nano /etc/exports
    /srv/shares/nfs IP/Subnet(rw,sync,no_subtree_check) 
exportfs -a
systemctl start nfs-kernel-server
systemctl enable nfs-kernel-server

# Проверка
showmount -e localhost
touch /srv/shares/nfs/nfs_test
ls /srv/shares/nfs/

# 2 VM

# Установка
apt-get update
apt-get install nfs-common

# Настройка и запуск
mkdir -p /mnt/shares
sudo chown ${USER}:${USER} -R /mnt/shares/
sudo mount -t nfs IP_1_VM:/srv/shares/nfs /mnt/shares

# Проверка
ls /mnt/shares

# Автоматическое монтирование
echo "IP_1_VM:/srv/shares/nfs /mnt/shares nfs defaults 0 0" | sudo tee -a /etc/fstab



# Дополнительные настройки
setfacl -m u:user:rwx /mnt/documents/file.txt # назначение прав доступа user к file.txt
setfacl -m g:group:rx /mnt/documents/directory # назначение прав доступа group к directory
setfacl -m m:rwx /mnt/documents/directory # назначение полного доступа к directory
getfacl /mnt/documents/file.txt # отобразит текущие права к file.txt
setfacl -x u:user1 /mnt/documents/file.txt # удаление прав доступа к file.txt