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

#
# prompt
#
RUN echo "export PS1=\"[\u@\h \W]\]# \"" >> /root/.bashrc
RUN echo 'alias ll="ls -l --color=auto"' >> /root/.bashrc
RUN echo '. ~/.bashrc' >> /root/.bash_profile
    
#CMD ["/sbin/init"]
