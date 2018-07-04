#!/bin/bash

set -v

SCRIPTDIR=$(cd $(dirname "$0") && pwd)
ROOTDIR="$SCRIPTDIR/../"
cd $ROOTDIR

KWSK_HOME=$1

git clone https://github.com/apache/incubator-openwhisk.git
sed -e "s:/home/jim/src:$PWD:" <whisk.properties >incubator-openwhisk/whisk.properties

go run ${KWSK_HOME}cmd/kwsk-server/main.go --port 8080 --istio $(minikube ip):32000 >kwsk.log 2>&1 &
KWSK_PID=$!

pushd incubator-openwhisk
./gradlew :tests:test --tests "system.basic.WskRest*"
STATUS=$?
popd

kill -- "-${KWSK_PID}"

exit $STATUS
