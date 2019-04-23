#!/bin/bash

id = $1

for ((x=id*8+1; x<=id*8+8; x++))
do
    rm -r node$x
    mkdir node$x
    ln -s $PWD/certs node$x/
    ln -s $PWD/system.param node$x/
    ln -s $PWD/pairing.param node$x/
done

a=9000
for ((x=id*8+1; x<=id*8+8; x++))
do
    cd node$x
    ((a++))
    ../node_8_0 $a ../certs/$x.pem ../certs/$x-key.pem ../contlist 0 0 0 &
    cd ..
done
if ((id == 1))
then
    tail -F node1/message.log
fi

