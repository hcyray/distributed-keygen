#!/bin/bash

for ((x=1; x<=1; x++))
do
    rm -r node$x
    mkdir node$x
    ln -s $PWD/certs node$x/
    ln -s $PWD/system.param node$x/
    ln -s $PWD/pairing.param node$x/
done

echo "Machine $id is ready!"
a=9000

for ((x=1; x<=1; x++))
do
    cd node$x
    ((a++))
    ../node_8_0 $a ../certs/$x.pem ../certs/$x-key.pem ../contlist 0 0 0 &
    cd ..
done
