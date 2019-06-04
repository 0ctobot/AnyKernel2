#!/system/bin/sh
# NeutrinoKernel Setup Assistant

# Initialize blkio cgroups
echo 0 > /dev/stune/blkio.group_idle
echo 0 > /dev/stune/foreground/blkio.group_idle
echo 0 > /dev/stune/background/blkio.group_idle
echo 0 > /dev/stune/top-app/blkio.group_idle
echo 0 > /dev/stune/rt/blkio.group_idle
echo 0 > /dev/stune/audio-app/blkio.group_idle

# Wait for Android to finish booting
while [ "$(getprop sys.boot_completed)" != 1 ]; do
    sleep 1;
done

# Execute post_boot init script
/vendor/bin/init.qcom.post_boot.sh

# Update msm_irqbalance configuration
stop vendor.msm_irqbalance
start vendor.msm_irqbalance

# Initiate self-destruct sequence if Neutrino isn't installed
if ! grep -q NeutrinoKernel /proc/version; then
    rm -r /data/adb/modules/NeutrinoSettings
    rm -f /data/adb/service.d/95-neutrino.sh
fi
