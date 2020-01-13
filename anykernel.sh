# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=Neutrino Kernel for the OnePlus 7 Series by @0ctobot
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus7
device.name2=guacamoleb
device.name3=OnePlus7Pro
device.name4=guacamole
device.name5=OnePlus7ProTMO
device.name6=guacamolet
device.name7=OnePlus7ProNR
device.name8=OnePlus7T
device.name9=hotdogb
device.name10=OnePlus7TPro
device.name11=hotdog
device.name12=OnePlus7TProNR
device.name13=hotdogg
supported.versions=10 - 11
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot
is_slot_device=1
ramdisk_compression=gzip

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## Select the correct image to flash
hotdog="$(grep -wom 1 hotdog*.* /system/build.prop | sed 's/.....$//')";
guacamole="$(grep -wom 1 guacamole*.* /system/build.prop | sed 's/.....$//')";
userflavor="$(file_getprop /system/build.prop "ro.build.user"):$(file_getprop /system/build.prop "ro.build.flavor")";
userflavor2="$(file_getprop2 /system/build.prop "ro.build.user"):$(file_getprop2 /system/build.prop "ro.build.flavor")";
if [ "$userflavor" == "jenkins:$hotdog-user" ] || [ "$userflavor2" == "jenkins:$guacamole-user" ]; then
  os="stock";
  os_string="OxygenOS/HydrogenOS";
else
  os="custom";
  os_string="a custom ROM";
fi;
ui_print " " "You are on $os_string!";

## AnyKernel install
dump_boot;

# Install the boot image
write_boot;

## end install
