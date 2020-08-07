#####################################################
#
# Affable server project / specific setup - ISIR
# `Server documentation`
#
#####################################################


##Requisites and infos
  * ssh access on port 8899
remove the key as asked if a warning appears
==ssh -o "StrictHostKeyChecking no" -p 8899 clara@barzilouik.space==

`user:` clara
`pwd :` affable808!
... in the sudoers list


  * LAN network (machines in sight) :
influxdb
mosquitto
mqttbridge


  * WAN network
`barzilouik.space:1883           ## for MQTT (no credentials)`
`http://barzilouik.space:3000    ## for Grafana access (admin/admin first time then change to admin/affable808!)`


  * DB
the influxdb is running and pingable (as a check):
`curl -sl -I http://influxdb:8086/ping`



##Install from `install.sh` script
  You can launch 'install.sh' from root repository
    * to get the needed `directories` created with the right permission
    * `build` modified docker compose in directories
    * `kill` previous docker sessions, and `launch` what is needed (docker-compose included)
    
   
 
##Various usages with docker install

- list active **containers**
`docker ps `
`docker kill CONTAINER_ID`
`docker rm CONTAINER_ID`

- in the **image directory**
`docker build -t sshd_python .`

- launching a **container**
`docker run --detach --name test -p 8899:22 sshd_python`

- on the **host**
`ssh -p 9000 root@localhost`

- access a **container** (log in):
`docker exec -it 90ca7c8e6a8e /bin/bash`

- watch **docker states**
`watch -n 4 docker ps -a`
`watch -n 4 docker image ls`


*********************************************************************
##Usages
###from python
==  cf https://www.influxdata.com/blog/getting-started-python-influxdb ==

`from influxdb import InfluxDBClient`

`client = InfluxDBClient(host='barzilouik.space', port=8086, username='', password='', ssl=False, verify_ssl=False)
client.create_database('pyexample')
client.get_list_database()
client.switch_database('pyexample')`

`client.query('SELECT "duration" FROM "pyexample"."autogen"."brushEvents" WHERE time > now() - 4d GROUP BY "user"')`

###with MQTT
A bridge is running on port 1883 
For the moment with preformatted topic like /home/bme280/temperature
We probalby want to have a that bridge after user testing:

`mosquitto_pub -h barzilouik.space -t /home/dht22/temperature -m 23`

If you want to do your own python bridge for user testing, use port 1884 :

`mosquitto_pub -h barzilouik.space  -t /topic/whatever -m 42`


##Test install
- test **grafana** access
curl -sl -I http://influxdb:8086/ping

- test **mosquitto** access
mosquitto_pub -h barzilouik.space -t /home/bme280/temperature -m 23

- test from **python**
(from examples in: https://www.influxdata.com/blog/getting-started-python-influxdb/)

`from influxdb import InfluxDBClient`
`client = InfluxDBClient(host='barzilouik.space', port=8086, username='', password='', ssl=False, verify_ssl=False)`
`client.create_database('pyexample')`
`client.get_list_database()`
`client.switch_database('pyexample')`

`client.query('SELECT "duration" FROM "pyexample"."autogen"."brushEvents" WHERE time > now() - 4d GROUP BY "user"')`
`
