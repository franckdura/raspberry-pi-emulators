if  [[ $1 = "-b" ]]; then
    cd rpi3b+
    mkdir src
    mkdir src/raspi4b-virtio
    apt-get update -y
    apt-get install -y wget unzip
    wget https://raspi.debian.net/tested/20220121_raspi_4_bullseye.img.xz -P ./src/raspi4b-virtio
    cd ./src/raspi4b-virtio
    unxz 20220121_raspi_4_bullseye.img.xz
    IMAGE=`find ./ -name '2*.img'`
    losetup -f --show -P $IMAGE > loop.txt
    LOOPDIR=$(cat loop.txt)
    LOOPDIRMODIF=$LOOPDIR"p1"
    mkdir /mnt/rpi
    mount $LOOPDIRMODIF /mnt/rpi
    mkdir ./boot4b
    cp -r /mnt/rpi/* ./boot4b
    umount /mnt/rpi
    losetup -d $LOOPDIR
    apt-get install -y qemu-utils 
    cp $IMAGE ./image-raspi4bvirtio-resized-8G.img
    qemu-img resize "image-raspi4bvirtio-resized-8G.img" 8G
    wget https://download.qemu.org/qemu-6.2.0.tar.xz
    cd ../../
    export DOCKER_BUILDKIT=1
    docker build -t raspi4bvirtio -f Dockerfile-virtio-raspi4b . 
    docker run -p 2222:2222 --name raspi4bvirtio -it -d raspi4bvirtio 
else
    # do nothing
    echo "nothing to build";
    docker start raspi4bvirtio
fi

docker exec -it raspi4bvirtio /bin/bash -c "./qemu-6.2.0/build/aarch64-softmmu/qemu-system-aarch64 -m 4096 -M virt -cpu cortex-a72 -smp 4 -kernel ./boot4b/vmlinuz-5.10.0-11-arm64 -initrd ./boot4b/initrd.img-5.10.0-11-arm64 -drive file=./20220121_raspi_4_bullseye.img,if=none,format=raw,id=hdroot -append 'rw root=/dev/vda2 console=ttyAMA0 loglevel=8 rootwait fsck.repair=yes memtest=1' -device virtio-blk-device,drive=hdroot -netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-device,netdev=net0 -no-reboot -nographic"
