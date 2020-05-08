#!/bin/bash
IMAGE="insightiq"
NAME=$IMAGE
DATASTORE="${HOME}/insightiq-datastore"
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
	docker run --privileged -d -v $DATASTORE:/datastore -p $HTTPSPORT:443 -e WITH_IPV6_DISABLED=TRUE --name=$NAME $IMAGE
	;;
	"logs")
	docker logs --follow $IMAGE
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
	docker exec -ti $NAME /usr/bin/passwd administrator
	;;
	*)
	echo "$0 [status|build|start|stop|clean|changepass|logs]"
esac
