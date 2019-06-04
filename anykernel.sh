# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
eval $(cat $home/props | grep -v '\.');

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
set_perm_recursive 0 0 755 644 $ramdisk/*;
set_perm_recursive 0 0 750 750 $ramdisk/init* $ramdisk/sbin;

## Select the correct image to flash
userflavor="$(file_getprop /system/build.prop "ro.build.user"):$(file_getprop /system/build.prop "ro.build.flavor")";
case "$userflavor" in
  OnePlus:OnePlus6-user|OnePlus:OnePlus6T-user) os="stock"; os_string="OxygenOS";;
  *) os="custom"; os_string="a custom ROM";;
esac;
ui_print " " "You are on $os_string!";
if [ ! -f $home/kernels/$os/Image.gz ]; then
  ui_print " " "There is no kernel for your OS in this zip! Aborting..."; exit 1;
fi;

## AnyKernel install
dump_boot;
write_boot;
## end install
