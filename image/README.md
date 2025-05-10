# Instrucciones para construir la imagen

Usando una maquina real o virtual Fedora 42

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
lorax -p Ututo -v 42 -r 42 \
  --volid Ututo_11_Beta \
  -s http://dl.fedoraproject.org/pub/fedora/linux/releases/42/Everything/x86_64/os/ \
  -s http://dl.fedoraproject.org/pub/fedora/linux/updates/42/Everything/x86_64/  \
  ./results/
```

```
mkksiso \
  --ks {path to repo}/image/kickstart/anaconda-ks-desktop.cfg \
    ./results/images/boot.iso \
    ututo11beta.iso
```

Copiar la imagen *ututo11beta.iso* a un pendrive o maquina origen de instalación.


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
Atención: La instalación desatendida borrará completamente el disco sda o vda

```
virsh start ututo11-alfa
```


> [!WARNING]
Atención: Luego de la instalación cambiar el orden de arranque para vda en lugar de sda, en Opciones de Arranque desactivar SATA CDROM1


### Ingresar por primera vez
```
ssh ututo@ututoalfa
```
Adivina la contraseña :wink:


Si no se reconoce el hostname se puede averiguar la IP con 
```
sudo virsh net-dhcp-leases default  
```

Comprobar el nombre de la distro
```
hostnamectl
```

```
     Static hostname: ututobeta
           Icon name: computer-vm
             Chassis: vm 🖴
          Machine ID: 7ca2e8b4eccc4e328577fef17bdf5888
             Boot ID: ee66b48a2ce94ad6bee00a22ece405f2
      Virtualization: kvm
    Operating System: Ututo Linux 11 (Araucaria-beta) 
         CPE OS Name: cpe:/o:ututoproject:ututo:42
      OS Support End: Tue 2025-05-13
OS Support Remaining: 7month 1d
              Kernel: Linux 6.10.12-200.fc42.x86_64
        Architecture: x86-64
     Hardware Vendor: QEMU
      Hardware Model: Standard PC _Q35 + ICH9, 2009_
    Firmware Version: 0.0.0
       Firmware Date: Fri 2015-02-06
        Firmware Age: 9y 8month 3d     

```


``` 
ututo@ututoalfa:~$ fastfetch --logo logos/ututo_logo_ascii_small.txt
                                            ututo@ututoalfa
                          ((**              ---------------
   ((                    ( ** *             OS: Ututo GNU/Linux 11 x86_64
 , .  .                  *  , *             Host: KVM/QEMU Standard PC (Q35 + ICH9, 2009) (pc-q35-9.0)
  ((((                 *( **** **           Kernel: Linux 6.10.12-200.fc42.x86_64
 ((((((                  *,** *             Uptime: 2 mins
 *                / /    (    (     ,/      Packages: 1729 (rpm)
  ((((             /*   ( (((( **// /       Shell: bash 5.2.26
 ((((((             //// (/(( ( ((*(        Display (QEMU Monitor): 1920x1080 @ 60 Hz in 15″
 ,                      .(,   /*            DE: Mate 1.28.2
  ((((                  ( (((( **           WM: Marco (X11)
 ((((((                  (((( (             WM Theme: BlueMenta
 .                ,/    ,(    /*            Theme: BlueMenta [GTK2/3/4]
  //((((/(         /*(( ( ((((              Icons: mate [GTK2/3/4]
   ((((((///(./ ( ( (((( ((((               Font: Sans (10pt) [GTK2/3/4]
         . *.*,//(((.   //*   ,             Cursor: mate (24px)
        ((,( / / ( ( ((     // //           Terminal: /dev/pts/1
                                            CPU: 11th Gen Intel(R) Core(TM) i5-11500H (5) @ 2.92 GHz
                                            GPU: RedHat Virtio 1.0 GPU
                                            Memory: 933.44 MiB / 1.74 GiB (52%)
                                            Swap: 256.00 KiB / 7.74 GiB (0%)
                                            Disk (/): 3.13 GiB / 18.41 GiB (17%) - btrfs
                                            Disk (/run/media/ututo/Ututo_11_Alfa): 841.85 MiB / 841.85 MiB (100%) - iso9660 [Read-only]
                                            Local IP (enp1s0): 192.168.122.78/24
                                            Locale: es_AR.UTF-8

                                                                    
                                                                    
ututo@ututobeta:~$ 


``` 


# Instrucciones para construir la imagen livecd

``` 
livecd-creator --config {path to repo}/image/kickstart/ututo-live-mate.ks \
  --product=Ututo \
  --fslabel=ututo11live
``` 
