# raspberry-pi-emulators
This repository includes solutions to easily deploy Raspberry Pï emulators on any Debian-based operating system supporting Docker.

[**QEMU**]("https://github.com/qemu/qemu"), licensed under the [GNU General Public License, version 2]("https://github.com/qemu/qemu/blob/master/COPYING"), is the emulator software supporting all the presented boards, which are initially ARM-based. 

This project uses [Docker]("https://github.com/docker/docker-ce-packaging"), which is licensed under the [Apache 2.0 License]("https://github.com/docker/docker-ce-packaging/blob/master/LICENSE").

### **[Set up](#setup)**<br>
### **[Raspberry PI 2b](#rpi2b)**<br>
### **[Raspberry PI 3b+](#rpi3b)**<br>
### **[Raspberry PI 4b](#rpi4b)**<br>
### **[Terminate](#terminate)**<br>


<br>

---

<br>


## <a id="setup"></a>**Set Up**

<br>

- If **Docker** has never been installed on your system

Please run


```Bash
bash docker-install.sh
```

Also, the `dos2unix` package is required.

```Bash
apt-get install dos2unix
```



<br>

## <a id="rpi2b"></a>**Raspberry PI 2b**
<br>
This script runs the official Qemu 2.9.0 implementation of the Raspberry Pi 2b board, named `raspi2`, in a Docker container.
<br><br>

> It implements :
> - CPU Broadcom 2709 quad core cortex-a7 (ARM 32 bits)
> - 1 GB RAM
> - Raspbian OS (Jessie 2016-05-27 release)
> - Raspberry Pi 2 board
> - No networking

<br>


First, use the command below to correctly format the script

```bash
dos2unix rpi2b/qemu-official-raspi2b-docker.sh
```
If it is the first time, to **build and install dependencies**, please run
```bash
bash rpi2b/qemu-official-raspi2b-docker.sh -b
# default login : pi
# default password : raspberry
```
**Otherwise**, please just run
```bash
bash rpi2b/qemu-official-raspi2b-docker.sh
``` 

## <a id="rpi3b"></a>**Raspberry PI 3b+**
<br>
This script runs the official Qemu 6.2.0 implementation of the Raspberry Pi 3b+ board, named `raspi3b`, in a Docker container.

<br>

> It implements :
> - CPU Broadcom 2710 quad core cortex-a53 (ARMv8 64 bits)
> - 1 GB RAM
> - Raspios-arm64 (Bullseye 2022-01-28 release)
> - Raspberry Pi 3b+ board
> - Networking & port forwarding from 2222 (host) to 22 (guest)


<br>

First, use the command below to correctly format the script 
```bash
dos2unix rpi3b+/qemu-official-raspi3b-docker.sh
```
If it is the first time, to **build and install dependencies**, please run
```bash
bash rpi3b+/qemu-official-raspi3b-docker.sh -b
# default login : pi
# default password : raspberry
```
**Otherwise** 
```bash
bash rpi3b+/qemu-official-raspi3b-docker.sh
``` 

<br>

## <a id="rpi4b"></a>**Raspberry PI 4b**
<br>
This script runs a virtio machine (`virt`), implementing the same hardware as a Raspberry Pi 4b with a `raspios-rpi4-arm64` OS.

<br>

> It implements :
> - Virtual CPU quad core cortex-a72 (ARMv8 64 bits)
> - 4 GB RAM
> - Raspios-arm64 (Bullseye-rpi4 2022-01-21 release)
> - Networking & port forwarding from 2222 (host) to 22 (guest)

First, use the command below to correctly format the script 
```bash
dos2unix rpi4b/qemu-virtio-raspi4b-docker.sh
```
If it is the first time, to **build and install dependencies**, please run
```bash
bash qemu-virtio-raspi4b-docker.sh -b
# default login : root
# default password : 
```
**Otherwise** 
```bash
bash rpi4b/qemu-virtio-raspi4b-docker.sh
``` 
<br>

## <a id="terminate"></a>**Terminate**

When you want to **stop** your containers, run
```bash
dos2unix stop-containers.sh && bash stop-containers.sh
```

When you want to **remove** your containers and the associated files, please run
```bash
dos2unix remove-containers.sh && bash remove-containers.sh -r "YOURDEVICE"
# with YOURDEVICE being either raspi2b, raspi3b or raspi4bvirtio
```

<br>

## **License**
This project is licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0.txt).

Copyright 2023 Franck Dura

Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
