# Script to build for the captivate and zip the package.
# Written by Evan alias ytt3r
# modified by kodos96

make aries_talon_defconfig

export LOCALVERSION="-I9000XWJVB-CL118186"
export KBUILD_BUILD_VERSION=$1
export INSTALL_MOD_PATH=./mod_inst
make modules -j`grep 'processor' /proc/cpuinfo | wc -l`
make modules_install

if [ -e ./usr/initrd_files/lib ]; then
 rm -rf ./usr/initrd_files/lib
fi

mkdir ./usr/initrd_files/lib
mkdir ./usr/initrd_files/lib/modules

for i in `find mod_inst -name "*.ko"`; do
 cp $i ./usr/initrd_files/lib/modules/
done

rm -rf ./mod_inst
unzip ./usr/prebuilt_ko.zip -d ./usr/initrd_files/lib/modules/

make -j`grep 'processor' /proc/cpuinfo | wc -l`
cp arch/arm/boot/zImage releasetools
cd releasetools
zip * Talon

echo "Finished."
