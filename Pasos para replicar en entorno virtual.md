# Instrucciones de de como Convertir una imagen de feora al core minimo necesario
## Paso 1:
Instalar fedora everything desde el siguiente [link](https://alt.fedoraproject.org/), en el Instalador Anaconda seleccionar instalacíon minima.
## Paso 2:
Remover los siguientes paquetes:
* google-\* (Fonts)
* systemd-boot-unigned
* sdubby  

```
dnf remove google-* systemd-boot-unsigned sdubby
```
## Paso 3:
Definir que gestor de paquetes utilizar :

|          |  versión dnf5          | versión microdnf            |
|----------|------------------------|-----------------------------|
| Instalar | dnf install dnf5       | dnf install microdnf.x86_64 |
| Eliminar | dnf5 remove dnf libdnf | microdnf remove dnf         |