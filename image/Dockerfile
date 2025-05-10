FROM fedora:42
RUN dnf update -y
RUN dnf install -y lorax livecd-tools openssh-clients

RUN  mkdir image

COPY kickstart image/kickstart
COPY createiso.sh image/createiso.sh
RUN chmod +x image/createiso.sh

CMD ["/bin/bash","/image/createiso.sh"]
