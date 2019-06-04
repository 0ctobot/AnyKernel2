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

# begin ramdisk changes

# If the kernel image and dtbs are separated in the zip
decomp_img=$home/kernels/$os/Image
comp_img=$decomp_img.gz
if [ -f $comp_img ]; then
  # Hexpatch the kernel if Magisk is installed ('skip_initramfs' -> 'want_initramfs')
  if [ -d $ramdisk/.backup ]; then
    ui_print " " "Magisk detected! Patching kernel so reflashing Magisk is not necessary...";
    $bin/magiskboot --decompress $comp_img $decomp_img;
    $bin/magiskboot --hexpatch $decomp_img 736B69705F696E697472616D667300 77616E745F696E697472616D667300;
    $bin/magiskboot --compress=gzip $decomp_img $comp_img;
  fi;

  # Concatenate all of the dtbs to the kernel
  cat $comp_img $home/dtbs/*.dtb > $home/Image.gz-dtb;
fi;

# end ramdisk changes

write_boot;
## end install
