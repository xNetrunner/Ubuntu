# 1 VM
apt-get update
apt install nfs-kernel-server nfs-common -y

mkdir -p /srv/shares/nfs
chown ${USER}:${USER} -R /srv/shares/nfs/

nano /etc/exports
/srv/shares/nfs subnet(rw,sync,no_subtree_check) 
exportfs -a

systemctl start nfs-kernel-server
systemctl enable nfs-kernel-server

showmount -e localhost
touch /srv/shares/nfs/nfs_test
ls /srv/shares/nfs/

# 2 VM
apt-get update
apt-get install nfs-common

mkdir -p /mnt/shares
sudo chown ${USER}:${USER} -R /mnt/shares/
sudo mount -t nfs IP_server:/srv/shares/nfs /mnt/shares
ls /mnt/shares
echo "IP_server:/srv/shares/nfs /mnt/shares nfs defaults 0 0" | sudo tee -a /etc/fstab