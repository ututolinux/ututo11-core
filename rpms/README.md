
# Este es el repositorio de paquetes personalizados

## Pasos para el build , por ejemplo de *ututo-release* :
```
cd rpms
cd ututo-release

fedpkg --release f40 mockbuild
```

## Mover los rpm al repo:

```
mv results_ututo-release/40/1/ututo-release-40-1.noarch.rpm \
    results_ututo-release/40/1/ututo-release-common-40-1.noarch.rpm \
    results_ututo-release/40/1/ ututo-release-identity-basic-40-1.noarch.rpm \
    results_ututo-release/40/1/ututo-release-identity-workstation-40-1.noarch.rpm \
    results_ututo-release/40/1/ututo-release-workstation-40-1.noarch.rpm \
    ~/ututo/updates/11/Packages/u
``` 

Recrear repodata
``` 
cd ~/ututo/updates/11
createrepo .
```

Publicar repo
```
cd ~/ututo
scp -r updates user@webserver:/var/www/localhost/htdocs
```

## Pasos para la instalación:
```
sudo dnf install results_ututo-release/40/1/ututo-release-40-1.noarch.rpm results_ututo-release/40/1/ututo-release-common-40-1.noarch.rpm results_ututo-release/40/1/ututo-release-identity-basic-40-1.noarch.rpm --allowerasing
```


