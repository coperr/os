## This is an old project (was written years ago), will maybe try to push it further
enable i386 packages and update
```
sudo dpkg --add-architecture i386
sudo apt update
```

install multilib & build tools + qemu/grub/xorriso for ISO creation
```
sudo apt install build-essential gcc-multilib libc6-dev-i386 binutils qemu-system-i386 grub-pc-bin xorriso
```

from your project directory
```
make clean
make CROSS=
```
or run the ISO and QEMU
```
make run CROSS=
```
