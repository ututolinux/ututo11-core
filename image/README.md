# Instrucciones para construir la imagen

Usando una maquina real o virtual Fedora 40

### Si no lo hiciste clonar este repo:

Usando http:
```
git clone https://github.com/ututolinux/ututo11-core.git
```

O usando ssh
```
git clone git@github.com:ututolinux/ututo11-core.git
```



### A partir de ahora como root:
```
sudo su -
```

```
lorax -p Fedora -v 40 -r 40 \
    -s http://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/ \
    -s http://dl.fedoraproject.org/pub/fedora/linux/updates/40/Everything/x86_64/ \
    ./results/
```

```
mkksiso -V "Ututo11Alfa" --rm "quiet" --ks  {path to repo}/image/kickstart/anaconda-ks.cfg \ 
    ./results/images/boot.iso \
    ututo11alpha.iso
```

Copiar la imagen *ututo11alpha.iso* a un pendrive o maquina origen de instalación.


### Si usas qemu para crear una maquina virtual:

Asumiendo que tu usuario es ututo, sino cambiar el path y editar el xml

### Crear el disco
```
qemu-img create -f qcow2 /home/ututo/.local/share/libvirt/images/ututo.qcow2 20G
```

### Copiar bios
```
cp {path to repo}/virtualmachine/ututo11-alfa_VARS.fd
```

### Crear la VM
```
virsh create {path to repo}/virtualmachine/ututo11-alfa.kvm.xml
```

### Arrancar la VM

> [!WARNING]
Atención: La instalación desatendida borrará completamente el disco vda

```
virsh start ututo11-alfa
```


> [!WARNING]
Atención: Luego de la instalación cambiar el orden de arranque para vda en lugar de sda, en Opciones de Arranque desactivar SATA CDROM1


### Ingresar por primera vez
```
ssh ututo@ututo
```
Adivina la contraseña :wink:


Si no se reconoce el hostname se puede averiguar la IP con 
```
sudo virsh net-dhcp-leases default  
```

### Copiar los rpms

```
scp {path to repo}/rpms/generic-release/results_generic-release/40/0.2/generic-release-40-0.2.noarch.rpm \
    {path to repo}/rpms/generic-release/results_generic-release/40/0.2/generic-release-common-40-0.2.noarch.rpm \
    ututo@ututo:
```

### Ingresar e instalar RPMs
```
ssh ututo@ututo
```

```
sudo dnf install generic-release-40-0.2.noarch.rpm generic-release-common-40-0.2.noarch.rpm --allowerasing
```


Comprobar que cambia el nombre de la distro
```
hostnamectl
```

```
 Static hostname: ututodev
       Icon name: computer-vm
         Chassis: vm 🖴
      Machine ID: 6b5d34f70ae5458d8b005052598dcb6d
         Boot ID: c3860f498637411e965841427d03b995
  Virtualization: kvm
Operating System: Ututo GNU/Linux 11 (Once-alfa)  
     CPE OS Name: cpe:/o:ututo:ututo:11
          Kernel: Linux 6.10.11-200.fc40.x86_64
    Architecture: x86-64
 Hardware Vendor: QEMU
  Hardware Model: Standard PC _Q35 + ICH9, 2009_
Firmware Version: 0.0.0
   Firmware Date: Fri 2015-02-06
    Firmware Age: 9y 7month 3w 5d      
```



