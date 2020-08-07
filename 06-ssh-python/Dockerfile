#bump to 18.04
FROM ubuntu:18.04

### install systemd
ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y systemd systemd-sysv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
###

# from https://docs.docker.com/engine/examples/running_ssh_service/
# buid with 'docker build -t sshd_python .'
#
LABEL maintainer="Vincent" \
      description="Ubuntu with python and ssh"

RUN apt-get update && apt-get install -y openssh-server python3-pip
RUN apt-get install -y python3 
RUN apt-get install -y nano vim wget
RUN apt-get install -y curl sudo iputils-ping 
RUN apt-get install -y mosquitto 
RUN apt-get install -y mosquitto-clients
RUN apt-get install -y make build-essential llvm libssl-dev zlib1g-dev libbz2-dev libreadline-dev  libncurses5-dev libncursesw5-dev xz-utils
RUN apt-get install -y sqlite3
RUN apt-get install -y python3-paho-mqtt python3-influxdb

#RUN mkdir /var/run/sshd
#RUN echo 'root:affable808!' | chpasswd
#RUN sed -i 's/\#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config

#RUN echo 'clara  ALL=(ALL) ALL' > /etc/sudoers

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

## from https://github.com/krlmlr/debian-ssh
## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory, but also be able to sudo

#RUN useradd clara \
#        && mkdir /home/clara \
#        && chown clara:clara /home/clara \
#        && addgroup clara staff \
#        && addgroup clara sudo \
#        && usermod --shell /bin/bash clara \
#        && true

#RUN mkdir /home/clara/examples
#RUN chown -R clara:clara /home/clara/examples

#RUN echo 'clara:affable808!' | chpasswd

#RUN ln -sf /usr/bin/pip3 /usr/bin/pip
#RUN ln -sf /usr/bin/python3 /usr/bin/python

#RUN python3 -m pip install paho-mqtt
#RUN python3 -m pip install influxdb

# EXPOSE 22
# CMD ["/usr/sbin/sshd", "-D"]

# lauch systemd through
RUN systemctl enable ssh

#COPY requirements.txt /
#RUN pip install -r /requirements.txt

# COPY ./env/.bashrc:/home/clara/.bashrc
# COPY ./env/.profile:/home/clara/.profile
# COPY ./examples/bridge_influx_mqtt.py:/home/clara/examples/bridge_influx_mqtt.py

#COPY ./sftp/users.conf:/

#COPY . /app
#WORKDIR /app

RUN cat /etc/group
RUN cat /etc/passwd
RUN cat /etc/shadow
RUN cat /etc/gshadow

RUN rm -rf /home /var/log

#CMD ["python3", "-u", "main.py"]

