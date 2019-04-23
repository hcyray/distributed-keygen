#!/bin/bash

id=$1
a=9000
b=0

for ((x=id*8+1+b; x<=id*8+8; x++))
do
    rm -r node$x
    mkdir node$x
    ln -s $PWD/certs node$x/
    ln -s $PWD/system.param node$x/
    ln -s $PWD/pairing.param node$x/
done

echo "Machine $id is ready!"


for ((x=id*8+1+b; x<=id*8+8; x++))
do
    cd node$x
    ../node_8_0 $a ../certs/$x.pem ../certs/$x-key.pem ../contlist 0 0 0 &
    cd ..
    ((a++))
done
