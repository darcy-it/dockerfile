#
# Dockerfile
#
# https://gallery.ecr.aws/amazonlinux/amazonlinux
#
FROM public.ecr.aws/amazonlinux/amazonlinux:2.0.20230822.0

RUN amazon-linux-extras install -y

RUN yum install \
    systemd \
    sudo \
    tar \
    zip \
    unzip \
    wget \
    vim \
    git \
    nmap \
    jq \
    telnet \
    iputils \
    bind-utils \
    procps-ng \
    net-tools \
    openssh-clients \
    openssh-server \
    openssh-server-sysvinit \
    initscripts \
    passwd \
    iproute \
    -y

RUN yum clean all && \
    rm -rf /var/cache/yum/*
    
CMD ["/sbin/init"]
