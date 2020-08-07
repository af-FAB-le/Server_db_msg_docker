#!/bin/bash


export DATA_DIR=/var/lib/affable

echo 'docker-compose down'
docker-compose down
#docker container prune
docker image prune

# for host file permissions :
# https://medium.com/@nielssj/docker-volumes-and-file-system-permissions-772c1aee23ca

sudo mkdir -p ${DATA_DIR}/saves
sudo mkdir -p ${DATA_DIR}/mosquitto/data ${DATA_DIR}/mosquitto/log ${DATA_DIR}/influxdb ${DATA_DIR}/grafana ${DATA_DIR}/sshd-python
sudo mkdir -p ${DATA_DIR}/sftp/upload
sudo mkdir -p ${DATA_DIR}/dokuwiki

# saves
sudo mkdir -p /var/lib/affable_saves
tar zcvf /var/lib/affable_saves/saves.tar ${DATA_DIR}/


sudo chown -R 1883:1883 ${DATA_DIR}/mosquitto
sudo chown -R 472:472 ${DATA_DIR}/grafana
#sudo chown -R 2222:2222 ${DATA_DIR}/sftp
sudo chmod 775 -R ${DATA_DIR}/sftp 
sudo chmod 775 -R ${DATA_DIR}/dokuwiki
sudo chmod g+s ${DATA_DIR}/sftp
sudo chmod g+s ${DATA_DIR}/dokuwiki

docker-compose up --build -d

echo 'docker-compose up -d'
