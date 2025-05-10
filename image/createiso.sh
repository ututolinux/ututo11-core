#/usr/bin/bash
if [ -z "$SSH_USER" ]
then
	SSH_USER=`whoami`
fi
if [ -z "$SSH_HOST" ]
then
	SSH_HOST=ututo.nivel7.com.ar
fi
if ! [ -z "$SSH_PRIVATE_KEY" ]
then
    mkdir -p /root/.ssh && \
    echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    ssh-keyscan -H "$SSH_HOST"  >> /root/.ssh/known_hosts
fi

REPO=../
DEST="$SSH_USER"@"$SSH_HOST":/var/www/ututo/descargas/htdocs/iso/

sudo lorax -p Ututo -v 42 -r 42 --volid Ututo_11_Beta -s http://dl.fedoraproject.org/pub/fedora/linux/releases/42/Everything/x86_64/os/ -s http://dl.fedoraproject.org/pub/fedora/linux/updates/42/Everything/x86_64/ -s https://dl.ututo.ar/updates/11/  ./results/ && \
sudo mkksiso --ks "${REPO}"/image/kickstart/anaconda-ks-desktop.cfg results/images/boot.iso ututo11beta.iso && \
rm -rf ./results/ ./pylorax.log ./program.log ./pkglists ./lorax.log ./debugdata && \
md5sum ututo11beta.iso > ututo11beta.iso.md5 && \
scp ututo11beta.iso.md5 ututo11beta.iso "${DEST}" && \
rm -f ututo11beta.iso.md5 ututo11beta.iso

sudo livecd-creator --config "${REPO}"/image/kickstart/ututo-live-mate.ks --product=Ututo --fslabel=Ututo_Live_11_Beta && \
mv Ututo_Live_11_Beta.iso Ututo-Live-x86_64-11-Beta.iso && \
md5sum Ututo-Live-x86_64-11-Beta.iso > Ututo-Live-x86_64-11-Beta.iso.md5 && \
scp Ututo-Live-x86_64-11-Beta.iso.md5 Ututo-Live-x86_64-11-Beta.iso "${DEST}" && \
rm -f Ututo-Live-x86_64-11-Beta.iso.md5 Ututo-Live-x86_64-11-Beta.iso

