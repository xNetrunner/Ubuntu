apt install nfs-kernel-server nfs-common -y

mkdir -p /srv/shares/nfs
chown ${USER}:${USER} -R /srv/shares/nfs/

nano /etc/exports
/srv/shares/nfs 10.0.0.0/8(rw,sync,no_subtree_check) 
exportfs -a

systemctl start nfs-kernel-server
systemctl enable nfs-kernel-server