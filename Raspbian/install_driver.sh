#!/bin/bash 

row=`grep -nr "dtoverlay=vc4-fkms-v3d" /boot/config.txt | awk -F ':' '{if(NR==1)printf $1}'`
if [ -n "$row" ]; then
	sudo sed -i -e ''"$row"'s/dtoverlay=vc4-fkms-v3d/#dtoverlay=vc4-fkms-v3d/' /boot/config.txt
fi

echo "Enable spi bus..."
sudo sed 's/dtparam=spi=on//g' -i /boot/config.txt
sudo sed '/^$/d' -i /boot/config.txt
sudo sed '$a dtparam=spi=on' -i /boot/config.txt

echo "Enable uctronics-hslcd35 driver..."
sudo sed 's/dtoverlay=uctronics-hslcd35//g' -i /boot/config.txt
sudo sed '/^$/d' -i /boot/config.txt
sudo sed '$a dtoverlay=uctronics-hslcd35' -i /boot/config.txt
sudo cp ./usr/$(uname -r)/uctronics-hslcd35-overlay.dtb /boot/overlays/uctronics-hslcd35.dtbo

echo "Change display resolution..."
sudo sed 's/hdmi_force_hotplug=1//g' -i /boot/config.txt
sudo sed '/^$/d' -i /boot/config.txt
sudo sed '$a hdmi_force_hotplug=1' -i /boot/config.txt

sudo sed 's/hdmi_group=2//g' -i /boot/config.txt
sudo sed '/^$/d' -i /boot/config.txt
sudo sed '$a hdmi_group=2' -i /boot/config.txt

sudo sed 's/hdmi_mode=87//g' -i /boot/config.txt
sudo sed '/^$/d' -i /boot/config.txt
sudo sed '$a hdmi_mode=87' -i /boot/config.txt

sudo sed 's/hdmi_cvt 480 320 60 6 0 0 0//g' -i /boot/config.txt
sudo sed '/^$/d' -i /boot/config.txt
sudo sed '$a hdmi_cvt 480 320 60 6 0 0 0' -i /boot/config.txt

sudo sed 's/hdmi_driver=2//g' -i /boot/config.txt
sudo sed '/^$/d' -i /boot/config.txt
sudo sed '$a hdmi_driver=2' -i /boot/config.txt

echo "Install FBCP..."
sudo apt-get install cmake
sudo mkdir ./rpi-fbcp/build
cd ./rpi-fbcp/build/
sudo cmake ..
sudo make
sudo install fbcp /usr/local/bin/fbcp
cd - > /dev/null
sudo sed '/fi/a\fbcp &' -i /etc/rc.local
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

