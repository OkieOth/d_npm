#!/bin/bash

scriptPos=${0%/*}


source "$scriptPos/image_conf.sh"

contName=npm_devserver

if [ -z $DATA_DIR ]; then
    echo "need a env variable DATA_DIR that points to project dir - cancel"
    exit 1
fi

if ! [ -d "$DATA_DIR" ]; then
    echo "DATA_DIR doesn't point to a directory - cancel"
    echo "DATA_DIR=$DATA_DIR"
    exit 1
fi

if ! [ -f "$DATA_DIR/package.json" ]; then
    echo "DATA_DIR doesn't contain package.json - cancel"
    echo "DATA_DIR=$DATA_DIR"
    exit 1
fi

dataDir=`pushd "$DATA_DIR" > /dev/null && pwd && popd > /dev/null`

aktImgName=`docker images |  grep -G "$imageBase *$imageTag *" | awk '{print $1":"$2}'`

if [ "$aktImgName" == "$imageBase:$imageTag" ]
then
        echo "run container from image: $aktImgName"
else
	if docker build -t $imageName $scriptPos/../image
    then
        echo -en "\033[1;34mImage created: $imageName \033[0m\n"
    else
        echo -en "\033[1;31mError while create image: $imageName \033[0m\n"
        exit 1
    fi
fi

if docker ps -a -f name="$contName" | grep "$contName" > /dev/null; then
    docker start $contName
else
#    docker run --rm --entrypoint /bin/bash -it --name "$contName" -v ${dataDir}:/opt/myproject "$imageBase:$imageTag" 
    docker run --rm --name "$contName" -p 8080:8080 -v ${dataDir}:/opt/myproject "$imageBase:$imageTag" 
fi


