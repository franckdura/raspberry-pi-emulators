if  [[ $1 = "-b" ]]; then
    mkdir src
    mkdir src/raspi3b
    apt-get update -y
    apt-get install -y wget unzip
    wget https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2022-01-28/2022-01-28-raspios-bullseye-arm64.zip -P ./src/raspi3b
    cd ./src/raspi3b
    unzip 2022-01-28-raspios-bullseye-arm64.zip
    IMAGE=`find ./ -name '2*.img'`
    losetup -f --show -P $IMAGE > loop.txt
    LOOPDIR=$(cat loop.txt)
    LOOPDIRMODIF=$LOOPDIR"p1"
    mkdir /mnt/rpi
    mount $LOOPDIRMODIF /mnt/rpi
    mkdir ./boot3b
    cp -r /mnt/rpi/* ./boot3b
    umount /mnt/rpi
    losetup -d $LOOPDIR
    apt-get install -y qemu-utils 
    cp $IMAGE ./image-raspi3b-resized-8G.img
    qemu-img resize "image-raspi3b-resized-8G.img" 8G
    wget https://download.qemu.org/qemu-6.2.0.tar.xz
    cd ../../
    export DOCKER_BUILDKIT=1
    docker build -t raspi3b -f Dockerfile-raspi3b . 
    docker run -p 2222:2222 --name raspi3b -it -d raspi3b

else
    echo "nothing to build";
    docker start raspi3b;
fi

docker exec -it raspi3b /bin/bash -c "./qemu-6.2.0/build/aarch64-softmmu/qemu-system-aarch64 -m 1024 -M raspi3b -cpu cortex-a53 -smp 4 -kernel ./boot3b/kernel8.img -dtb ./boot3b/bcm2710-rpi-3-b-plus.dtb -drive file=./image-raspi3b-resized-8G.img,if=sd,format=raw -append 'rw earlycon=pl011,0x3f201000 console=ttyAMA0 loglevel=8 root=/dev/mmcblk0p2 fsck.repair=yes net.ifnames=0 rootwait memtest=1' -device usb-net,netdev=net0 -netdev user,id=net0,ipv4=on,hostfwd=tcp::2222-:22 -nographic"
