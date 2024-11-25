# Punto 1: Paso a paso detallado del proceso

# Listar los discos disponibles
lsblk

# Ingresar al disco /dev/sdc para crear particiones
sudo fdisk /dev/sdc

# Crear la primera partición primaria de 1GB
n
p
1
+1G

# Crear la segunda partición primaria de 1GB
n
p
2
+1G

# Crear la tercera partición primaria de 1GB
n
p
3
+1G

# Crear la partición extendida de 3GB
n
e
4
+3G

# Crear particiones lógicas dentro de la extendida
# Primera partición lógica de 1.5GB
n
5
+1.5G

# Segunda partición lógica de 1.3GB
n
6
+1.3G

# Establecer la primera partición como Swap
t
1
82

# Establecer las particiones 2, 3, 5 y 6 como Linux LVM
t
2
8E
t
3
8E
t
5
8E
t
6
8E

# Guardar los cambios y salir
w

# Crear el sistema de archivos Swap en la partición 1
sudo mkswap /dev/sdc1
sudo swapon /dev/sdc1

# Verificar el uso de Swap
free -h

# Crear los volúmenes físicos (PV) con las particiones asignadas
sudo pvcreate /dev/sdc2 /dev/sdc3 /dev/sdc5 /dev/sdc6

# Crear los grupos de volúmenes
sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3
sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6

# Crear volúmenes lógicos
sudo lvcreate -L 1G vgDevelopers -n lvDevelopers
sudo lvcreate -L 1G vgDevelopers -n lvTesters
sudo lvcreate -L 0.8G vgDevelopers -n lvDevops
sudo lvcreate -L 0.8G vgAdmin -n lvAdmin

# Verificar los volúmenes creados
sudo lvs
sudo vgs
sudo pvs

# Crear sistemas de archivos en los volúmenes lógicos
sudo mkfs.ext4 /dev/vgDevelopers/lvDevelopers
sudo mkfs.ext4 /dev/vgDevelopers/lvTesters
sudo mkfs.ext4 /dev/vgDevelopers/lvDevops
sudo mkfs.ext4 /dev/vgAdmin/lvAdmin

# Crear puntos de montaje
sudo mkdir -p /mnt/lvDevelopers
sudo mkdir -p /mnt/lvTesters
sudo mkdir -p /mnt/lvDevops
sudo mkdir -p /mnt/lvAdmin

# Montar los volúmenes lógicos
sudo mount /dev/vgDevelopers/lvDevelopers /mnt/lvDevelopers
sudo mount /dev/vgDevelopers/lvTesters /mnt/lvTesters
sudo mount /dev/vgDevelopers/lvDevops /mnt/lvDevops
sudo mount /dev/vgAdmin/lvAdmin /mnt/lvAdmin

# Verificar los puntos de montaje
sudo df -h
sudo lsblk

