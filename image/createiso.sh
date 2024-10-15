REPO=../
DEST=ututo.nivel7.com.ar:/var/www/ututo/descargas/htdocs/iso/

sudo lorax -p Ututo -v 40 -r 40 --volid Ututo_11_Alfa -s http://dl.fedoraproject.org/pub/fedora/linux/releases/40/Everything/x86_64/os/ -s http://dl.fedoraproject.org/pub/fedora/linux/updates/40/Everything/x86_64/ -s https://dl.ututo.ar/updates/11/  ./results/
mkksiso --ks "${REPO}"/image/kickstart/anaconda-ks-desktop.cfg results/images/boot.iso ututo11alfa.iso
md5sum ututo11alfa.iso > ututo11alfa.iso.md5
scp ututo11alfa.iso.md5 ututo11alfa.iso "${DEST}"

sudo livecd-creator --config "${REPO}"/image/kickstart/ututo-live-mate.ks --product=Ututo --fslabel=Ututo_Live_11_Alfa
mv Ututo_Live_11_Alfa.iso Ututo-Live-x86_64-11-Alfa.iso
md5sum Ututo-Live-x86_64-11-Alfa.iso > Ututo-Live-x86_64-11-Alfa.iso.md5
scp Ututo-Live-x86_64-11-Alfa.iso "${DEST}"
