#!/bin/bash
IMAGE="insightiq"
NAME=$IMAGE
DATASTORE="/local/path/to/datastore"
HTTPPORT=18080
HTTPSPORT=18443



case $1 in
	"build")
	docker build -t $IMAGE .
	;;
	"stop")
	docker stop $NAME
	docker rm $NAME
	;;
	"start")
	docker run -d -v $DATASTORE:/datastore -p $HTTPPORT:80 -p $HTTPSPORT:443 --name=$NAME $IMAGE
	;;
	"clean")
	docker rmi $IMAGE
	;;
	"exec")
	docker exec -ti $NAME /bin/bash
	;;
	"status")
	docker ps -a | grep $NAME
	docker images | grep $IMAGE
	;;
	"changepass")
	docker exec -ti $NAME /usr/bin/passwd administrator --stdin
	;;
	*)
	echo "$0 [status|build|start|stop|clean|changepass]"
esac


