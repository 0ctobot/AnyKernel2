# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

# set up working directory variables
[ "$home" ] || home=$PWD;
bootimg=$home/boot.img;
bin=$home/tools;
patch=$home/patch;
ramdisk=$home/ramdisk;
split_img=$home/split_img;

## AnyKernel setup
eval $(cat $home/props | grep -v '\.')

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## Select the correct image to flash
userflavor="$(file_getprop /system/build.prop "ro.build.user"):$(file_getprop /system/build.prop "ro.build.flavor")";
case "$userflavor" in
  jenkins:qssi-user) os="stock"; os_string="OxygenOS/HydrogenOS";;
  *) os="custom"; os_string="a custom ROM";;
esac;
ui_print " " "You are on $os_string!";
if [ -f $home/kernels/$os/Image.gz ] && [ -f $home/kernels/$os/dtb ]; then
  mv $home/kernels/$os/Image.gz $home/Image.gz;
  mv $home/kernels/$os/dtb $home/dtb;
else
  ui_print " " "There is no kernel for your OS in this zip! Aborting..."; exit 1;
fi;

## AnyKernel install
dump_boot;

# Install the boot image
write_boot;

## end install
