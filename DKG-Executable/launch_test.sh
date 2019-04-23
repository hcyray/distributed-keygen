#!/bin/bash

function launch () {
    port=$1
    id=$2
    ./node_8_0 $port certs/$id.pem certs/$id-key.pem contlist 0 0 0
}

id = $1

for x in `seq $id*8+1 $id*8+8`
do
    rm -r node$x
    mkdir node$x
    ln -s $PWD/certs node$x/
    ln -s $PWD/system.param node$x/
    ln -s $PWD/pairing.param node$x/
done

a=9000
for x in `seq $id*8+1 $id*8+8`
do
    cd node$x
    ((a++))
    ../node_8_0 $a ../certs/$x.pem ../certs/$x-key.pem ../contlist 0 0 0 &
    cd ..
done
tail -F node1/message.log

