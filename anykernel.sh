# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Neutrino Kernel for the OnePlus 8 Series and OnePlus 9R by @0ctobot
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus8
device.name2=instantnoodle
device.name3=OnePlus8TMO
device.name4=instantnoodlet
device.name5=OnePlus8Visible
device.name6=instantnoodlevis
device.name7=OnePlus8Pro
device.name8=instantnoodlep
device.name9=OnePlus8T
device.name10=kebab
device.name11=OnePlus9R
device.name12=lemonades
supported.versions=11
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot
is_slot_device=1
ramdisk_compression=gzip

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
