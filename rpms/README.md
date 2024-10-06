
# Este es el repositorio de paquetes personalizados

## Pasos para el build , por ejemplo de *generic-release* :
```
cd rpms
cd generic-release

fedpkg --release f40 mockbuild
```

## Pasos para la instalación:
```
sudo dnf install results_ututo-release/40/1/ututo-release-40-1.noarch.rpm results_ututo-release/40/1/ututo-release-common-40-1.noarch.rpm results_ututo-release/40/1/ututo-release-identity-basic-40-1.noarch.rpm --allowerasing
```


