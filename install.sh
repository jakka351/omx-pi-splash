#!/bin/bash
#https://github.com/jakka351/omx-pi-splash
echo "                                                                     /$$                                              ";
echo "                                                                    | $$                                              ";
echo "        /$$$$$$        /$$$$$$/$$$$        /$$   /$$        /$$$$$$ | $$  /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$       ";
echo "       /$$__  $$      | $$_  $$_  $$      |  $$ /$$/       /$$__  $$| $$ |____  $$| $$  | $$ /$$__  $$ /$$__  $$      ";
echo "      | $$  \ $$      | $$ \ $$ \ $$       \  $$$$/       | $$  \ $$| $$  /$$$$$$$| $$  | $$| $$$$$$$$| $$  \__/      ";
echo "      | $$  | $$      | $$ | $$ | $$        >$$  $$       | $$  | $$| $$ /$$__  $$| $$  | $$| $$_____/| $$            ";
echo "      |  $$$$$$/      | $$ | $$ | $$       /$$/\  $$      | $$$$$$$/| $$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$            ";
echo "       \______/       |__/ |__/ |__/      |__/  \__/      | $$____/ |__/ \_______/ \____  $$ \_______/|__/            ";
echo "                                                          | $$                     /$$  | $$                          ";
echo "                                                          | $$                    |  $$$$$$/                          ";
echo "                                                          |__/                     \______/                           ";
echo "       /$$$$$$$  /$$$$$$        /$$$$$$  /$$$$$$$  /$$        /$$$$$$   /$$$$$$  /$$   /$$                            ";
echo "      | $$__  $$|_  $$_/       /$$__  $$| $$__  $$| $$       /$$__  $$ /$$__  $$| $$  | $$                            ";
echo "      | $$  \ $$  | $$        | $$  \__/| $$  \ $$| $$      | $$  \ $$| $$  \__/| $$  | $$                            ";
echo "      | $$$$$$$/  | $$        |  $$$$$$ | $$$$$$$/| $$      | $$$$$$$$|  $$$$$$ | $$$$$$$$                            ";
echo "      | $$____/   | $$         \____  $$| $$____/ | $$      | $$__  $$ \____  $$| $$__  $$                            ";
echo "      | $$        | $$         /$$  \ $$| $$      | $$      | $$  | $$ /$$  \ $$| $$  | $$                            ";
echo "      | $$       /$$$$$$      |  $$$$$$/| $$      | $$$$$$$$| $$  | $$|  $$$$$$/| $$  | $$                            ";
echo "      |__/      |______/       \______/ |__/      |________/|__/  |__/ \______/ |__/  |__/                            ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "                                                                                                                      ";
echo "       /$$                       /$$               /$$ /$$                                     /$$             /$$    ";
echo "      |__/                      | $$              | $$| $$                                    |__/            | $$    ";
echo "       /$$ /$$$$$$$   /$$$$$$$ /$$$$$$    /$$$$$$ | $$| $$        /$$$$$$$  /$$$$$$$  /$$$$$$  /$$  /$$$$$$  /$$$$$$  ";
echo "      | $$| $$__  $$ /$$_____/|_  $$_/   |____  $$| $$| $$       /$$_____/ /$$_____/ /$$__  $$| $$ /$$__  $$|_  $$_/  ";
echo "      | $$| $$  \ $$|  $$$$$$   | $$      /$$$$$$$| $$| $$      |  $$$$$$ | $$      | $$  \__/| $$| $$  \ $$  | $$    ";
echo "      | $$| $$  | $$ \____  $$  | $$ /$$ /$$__  $$| $$| $$       \____  $$| $$      | $$      | $$| $$  | $$  | $$ /$$";
echo "      | $$| $$  | $$ /$$$$$$$/  |  $$$$/|  $$$$$$$| $$| $$       /$$$$$$$/|  $$$$$$$| $$      | $$| $$$$$$$/  |  $$$$/";
echo "      |__/|__/  |__/|_______/    \___/   \_______/|__/|__/      |_______/  \_______/|__/      |__/| $$____/    \___/  ";
echo "                                                                                                  | $$                ";
echo "                                                                                                  | $$                ";
echo "                                                                                                  |__/                ";
sleep 5
sleep 0.1
sudo su - <<EOF
sudo apt update -y
sleep 0.1
sudo apt upgrade -y
sleep 0.1
sudo apt dist-upgrade -y
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
