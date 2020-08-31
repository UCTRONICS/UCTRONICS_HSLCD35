#!/bin/bash 
echo "Release spi bus..."
sudo sed 's/dtparam=spi=on//g' -i /boot/config.txt
echo "uninstall uctronics-hslcd35 driver..."
sudo sed 's/dtoverlay=uctronics-hslcd35//g' -i /boot/config.txt

echo " Recovery display resolution..."
sudo sed 's/hdmi_force_hotplug=1//g' -i /boot/config.txt
sudo sed 's/hdmi_group=2//g' -i /boot/config.txt
sudo sed 's/hdmi_mode=87//g' -i /boot/config.txt
sudo sed 's/hdmi_cvt 480 320 60 6 0 0 0//g' -i /boot/config.txt
sudo sed 's/hdmi_driver=2//g' -i /boot/config.txt
echo "reboot now?(y/n):"
read USER_INPUT
case $USER_INPUT in
'y'|'Y')
    echo "reboot"
    sudo reboot
;;
*)
    echo "cancel"
;;
esac

