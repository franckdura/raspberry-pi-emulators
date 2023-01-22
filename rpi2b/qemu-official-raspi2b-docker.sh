if  [[ $1 = "-b" ]]; then
    mkdir src
    mkdir src/raspi2b
    apt-get update -y
    apt-get install -y wget unzip
    wget http://downloads.raspberrypi.org/raspbian/images/raspbian-2016-05-31/2016-05-27-raspbian-jessie.zip -P ./src/raspi2b
    cd ./src/raspi2b
    unzip 2016-05-27-raspbian-jessie.zip
    losetup -f --show -P 2016-05-27-raspbian-jessie.img > loop.txt
    LOOPDIR=$(cat loop.txt)
    LOOPDIRMODIF=$LOOPDIR"p1"
    mkdir /mnt/rpi
    mount $LOOPDIRMODIF /mnt/rpi
    mkdir ./boot2b
    cp -r /mnt/rpi/* ./boot2b
    umount /mnt/rpi
    losetup -d $LOOPDIR
    apt-get install -y qemu-utils 
    cp 2016-05-27-raspbian-jessie.img ./image-raspi2b-resized-8G.img
    qemu-img resize "image-raspi2b-resized-8G.img" 8G
    wget https://download.qemu.org/qemu-2.9.0.tar.xz
    cd ../../  
    export DOCKER_BUILDKIT=1
    docker build -t raspi2b -f Dockerfile-raspi2b . 
    docker run --name raspi2b -it -d raspi2b 
else
    # do nothing
    echo "nothing to build";
    docker start raspi2b
fi


docker exec -it raspi2b /bin/bash -c "./qemu-2.9.0/build/arm-softmmu/qemu-system-arm -M raspi2 -append 'rw earlyprintk loglevel=8 console=ttyAMA0,115200 dwc_otg.lpm_enable=0 root=/dev/mmcblk0p2' -cpu cortex-a7 -dtb ./boot2b/bcm2709-rpi-2-b.dtb -sd 2016-05-27-raspbian-jessie.img -kernel ./boot2b/kernel7.img -m 1G -smp 4 -nographic"

