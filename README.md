# LLVM32cross
## LLVM build scripts for mingw32 cross build 

This package requires real or virtual Linux system (Debian) for build

1. install (virtual) Linux for build
2. build using cross-mingw32 cros-compiler toolchain
3. install resulting LLVM toolchain on Windows workstation

### Linux build host required for toolchain compiling

Use real hardware or any virtualization software like VirtualBox
to install Debian GNU/Linux (Jessie i386) -- you must use cross-compiling,
native MinGW/MSYS build is crap

1. create user on your build system, like
adduser ponyatov 
adduser ponyatov sudo
2. install required dev packages: gcc mingw32 ...
3. clone 

cd ~
git clone -o gh --depth=1 git@github.com:ponyatov/LLVM32cross.git

4. build toolchain

cd ~/LLVM32cross ; make

Toolchain build require lot of time and some resources:
1. some debian packages is obsolete, so first it will build
   modern tools required for LLVM:
* cmake
2. LLVM build itself requires lot time (clang in TODO, it much more ugly huge)

### Install on Win workstation

1. run winstall.bat to clone:

git clone -o gh --depth=1 git@github.com:ponyatov/LLVM32cross.git D:\LLVM 

this code will create D:\LLVM as github repo fork

2. then run winget.bat for get resulting toolchain from Linux build host:

cd D:\LLVM
pscp -r ponyatov@192.168.56.102:/home/ponyatov/LLVM32cross/mingw32 ./

3. add D:\LLVM\mingw32 to your user/system %PATH%

So now you can use full LLVM toolchain to hack your compiler/OS

