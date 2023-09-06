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
    supervisor \
    -y

#  aws cli install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -f awscliv2.zip

RUN yum install -y python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install supervisor && \
    mkdir -p /var/log/supervisor

RUN yum install httpd -y

RUN yum clean all && \
    rm -rf /var/cache/yum/*

# ssh setting
# ssh setting
RUN sudo ssh-keygen -A
RUN echo 'root:root' | chpasswd
RUN mkdir /var/run/sshd

# apache setting
RUN echo "darcy-it" > /var/www/html/index.html

# beep off
RUN sudo sed -i -e "2s:^#::" /etc/inputrc

# prompt
RUN echo "export PS1=\"[\u@\h \W]\]# \"" >> /root/.bashrc
# alias
RUN echo 'alias egrep="egrep --color=auto"' >> /root/.bashrc
RUN echo 'alias fgrep="fgrep --color=auto"' >> /root/.bashrc
RUN echo 'alias grep="grep --color=auto"' >> /root/.bashrc
RUN echo 'alias l.="ls -d .* --color=auto"' >> /root/.bashrc
RUN echo 'alias ll="ls -l --color=auto"' >> /root/.bashrc
RUN echo 'alias ls="ls --color=auto"' >> /root/.bashrc
RUN echo 'alias which="alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde"' >> /root/.bashrc
# supervisord
RUN echo "/usr/local/bin/supervisord -c /etc/supervisord.conf -s &" >> /root/.bashrc
# prifile
RUN echo '. ~/.bashrc' >> /root/.bash_profile

# コンテナが公開するポート番号
#EXPOSE 80

COPY supervisord.conf /etc/supervisord.conf    

CMD ["/usr/local/bin/supervisord"]
#CMD ["/usr/local/bin/supervisord", "-n"]
#CMD ["/usr/local/bin/supervisord", "&"]
#CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisord.conf"]
#CMD ["/sbin/init"]
#CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
