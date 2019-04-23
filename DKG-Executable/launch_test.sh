#!/bin/bash

id = $1

for x in `seq ((id*8+1)) ((id*8+8))`
do
    rm -r node$x
    mkdir node$x
    ln -s $PWD/certs node$x/
    ln -s $PWD/system.param node$x/
    ln -s $PWD/pairing.param node$x/
done

a=9000
for x in `seq ((id*8+1)) ((id*8+8))`
do
    cd node$x
    ((a++))
    ../node_8_0 $a ../certs/$x.pem ../certs/$x-key.pem ../contlist 0 0 0 &
    cd ..
done
if ((id == 0))
then
    tail -F node1/message.log
fi

