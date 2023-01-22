#!/bin/bash

while getopts r: option
do 
    case "${option}"
        in
        r)remove=${OPTARG};;
    esac
done

if  [[ $remove = "raspi2b" ]]; then
    docker stop raspi2b
    docker rm raspi2b
    rm -r ./rpi2b/src/raspi2b
    echo "All files have been deleted successfully."
elif  [[ $remove = "raspi3b" ]]; then
    docker stop raspi3b
    docker rm raspi3b
    rm -r ./rpi3b+/src/raspi3b
    echo "All files have been deleted successfully."
elif  [[ $remove = "raspi4bvirtio" ]]; then
    docker stop raspi4bvirtio
    docker rm raspi4bvirtio
    rm -r ./rpi4b/src/raspi4b-virtio
    echo "All files have been deleted successfully."
else
    echo "nothing to remove";

fi