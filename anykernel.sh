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

## AnyKernel install
dump_boot;

# Install the boot image
write_boot;

## end install
