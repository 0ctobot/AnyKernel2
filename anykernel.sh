# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

# set up working directory variables
test "$home" || home=$PWD;
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

install() {
  ## AnyKernel install
  dump_boot;

  # Clean up existing ramdisk overlays
  rm -rf $ramdisk/overlay;
  rm -rf $ramdisk/overlay.d;

  # Use the provided dtb
  if [ -e $home/dtb ]; then
    mv $home/dtb $home/split_img/;
  fi

  # Install the boot image
  write_boot;
}

install;

case $is_slot_device in
  1|auto)
    ui_print " ";
    ui_print "Installing to the secondary slot";
    slot_select=inactive;
    unset block;
    eval $(cat $home/props | grep '^block=' | grep -v '\.')
    reset_ak;
    install;
  ;;
esac

## end install
