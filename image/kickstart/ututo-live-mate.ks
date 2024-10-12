# Keyboard layouts
keyboard --vckeymap=es --xlayouts='es','latam'
# System language
lang es_AR.UTF-8

# Network information
timezone America/Argentina/Buenos_Aires --utc

selinux --enforcing
firewall --enabled --service=mdns
xconfig --startxonboot
zerombr
clearpart --all
part /boot/efi --fstype=efi --size=500
part biosboot --size 1 
part / --size 10000  --fstype ext4
	
services --enabled=NetworkManager,ModemManager --disabled=sshd
	
network --bootproto=dhcp --device=link --activate
rootpw --lock --iscrypted locked

shutdown
	
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch
#repo --name=updates-testing --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f$releasever&arch=$basearch 
url --mirrorlist=https://mirrors.fedoraproject.org/mirrorlist?repo=fedora-$releasever&arch=$basearch
repo --name=ututo --baseurl=http://ututo.nivel7.com.ar/ututo/updates/11/ 
	
	
%packages


# Explicitly specified here:
# <notting> walters: because otherwise dependency loops cause yum issues.
kernel
kernel-modules
kernel-modules-extra
	
	
# The point of a live image is to install
anaconda
anaconda-install-env-deps
anaconda-live
@anaconda-tools

# Anaconda has a weak dep on this and we don't want it on livecds, see
	
# https://fedoraproject.org/wiki/Changes/RemoveDeviceMapperMultipathFromWorkstationLiveCD
	
-fcoe-utils
-device-mapper-multipath
-sdubby
	
	
# Need aajohan-comfortaa-fonts for the SVG rnotes images
aajohan-comfortaa-fonts
# Without this, initramfs generation during live image creation fails: #1242586
dracut-live
	
	
# anaconda needs the locales available to run for different locales
glibc-all-langpacks
	
	
# provide the livesys scripts
livesys-scripts

# install env-group to resolve RhBug:1891500
@^mate-desktop-environment
-fedora-release
-fedora-release-matecompiz
ututo-release
ututo-release-common
ututo-release-identity-basic
ututo-logos


ccsm
simple-ccsm
emerald-themes
emerald
fusion-icon

# blacklist applications which breaks mate-desktop
-audacious

# office
#@libreoffice

# dsl tools
rp-pppoe

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# Drop things for size
-@3d-printing
-@admin-tools
-brasero
-fedora-icon-theme
-gnome-icon-theme
-gnome-icon-theme-symbolic
-gnome-software
-gnome-user-docs

-@mate-applications

# Help and art can be big, too
-gnome-user-docs
-evolution-help

# Legacy cmdline things we don't want
-telnet


%end


%post
# Enable livesys services
systemctl enable livesys.service
systemctl enable livesys-late.service
	
	
# enable tmpfs for /tmp
systemctl enable tmp.mount
	
	
# make it so that we don't do writing to the overlay for things which
# are just tmpdirs/caches
# note https://bugzilla.redhat.com/show_bug.cgi?id=1135475
cat >> /etc/fstab << EOF
vartmp   /var/tmp    tmpfs   defaults   0  0
EOF
	
	
# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
echo "Packages within this LiveCD"
rpm -qa --qf '%{size}\t%{name}-%{version}-%{release}.%{arch}\n' |sort -rn
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*
	
	
# go ahead and pre-make the man -k cache (#455968)
/usr/bin/mandb
	
	
# make sure there aren't core files lying around
rm -f /core*
	
	
# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed
	
	
# convince readahead not to collect
# FIXME: for systemd
	
echo 'File created by kickstart. See systemd-update-done.service(8).' \
    | tee /etc/.updated >/var/.updated
	
# Drop the rescue kernel and initramfs, we don't need them on the live media itself.
# See bug 1317709
rm -f /boot/*-rescue*
	
# Disable network service here, as doing it in the services line
# fails due to RHBZ #1369794
# systemctl disable network
	
	
# Remove machine-id on pre generated images
rm -f /etc/machine-id
touch /etc/machine-id
	
# set livesys session type
sed -i 's/^livesys_session=.*/livesys_session="mate"/' /etc/sysconfig/livesys

%end
