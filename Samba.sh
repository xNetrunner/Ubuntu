# 1 VM

useradd -m smbuser
passwd smbuser
echo ~smbuser

apt update
apt install samba -y
cp /etc/samba/smb.conf /etc/samba/smb_backup.conf

nano /etc/samba/smb.conf

[Public]
    comment = Public Folder
    path = /home/smbuser
    public = yes
    writable = no
    read only = yes
    guest ok = yes
    force create mode = 0777
    force directory mode = 0777

chmod 755 /home/smbuser
systemctl restart smbd.service

nano /etc/samba/smb.conf

[Private]
    comment = Private Folder
    path = /home/security
    public = no
    writable = yes
    read only = no
    guest ok = no
    force create mode = 0777
    force directory mode = 0777
    valid users = smbuser

mkdir /home/security
chmod 755 /home/security
systemctl restart smbd.service

smbpasswd -a smbuser
systemctl restart smbd.service

# 2 VM

apt update
apt install cifs-utils -y
mount.cifs //ip_1_VM/Public /mn
df -h
ls /mnt

apt install autofs
nano /etc/auto.master
/autofs_shares /etc/auto.shares --timeout=600 --browse
nano /etc/auto.shares
afs_public -fstype=cifs ://ip_1_VM/Public
mkdir /autofs_shares
chmod 777 /autofs_shares
systemctl restart autofs

# 3 VM

apt install nginx
nano /etc/nginx/sites-available/default
systemctl restart nginx