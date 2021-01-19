#!/bin/bash
#https://github.com/jakka351/omx-pi-splash

sleep 0.1
sudo su - <<EOF
sudo apt update -y
sleep 0.1
sudo apt upgrade -y
sleep 0.1
sudo apt dist-upgrade -y
sleep 0.1
sudo apt install -y omxplayer
sleep 0.1
sudo apt autoremove -y
sleep 0.1
sudo raspi-config nonint get_boot_splash
sleep 0.1
sudo raspi-config nonint do_boot_splash 0
sleep 0.1
sudo raspi-config nonint do_boot_behaviour B4
sleep 0.1
echo '
loglevel=3 quiet logo.nologo
' | sudo tee -a /boot/cmdline.txt > /dev/null
sleep 0.1
echo '
include splash.txt
' | sudo tee -a /boot/config.txt > /dev/null
sleep 0.1
echo '
disable_splash=1
avoid_warnings=2
gpu_mem=128
' | sudo tee /boot/splash.txt > /dev/null
sleep 0.1
echo '
[Unit]
Description=Splash Video
DefaultDependencies=no
After=local-fs.target

[Service]
ExecStart=/usr/bin/omxplayer -b /boot/splash.mp4
StandardInput=tty
StandardOutput=tty

[Install]
WantedBy=sysinit.target
' | sudo tee /lib/systemd/system/splash.service > /dev/null
sleep 0.1
sudo cp ./splash.mp4 /boot/splash.mp4
sleep 0.1
sudo systemctl daemon-reload
sleep 0.1
sudo systemctl enable splash.service
sleep 0.1
sudo systemctl start splash.service
sleep 0.1
#sudo cat <<EOF | sudo tee /lib/systemd/system/splash.service > /dev/null
#
EOF
