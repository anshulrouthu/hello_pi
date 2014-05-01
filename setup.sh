#!/bin/sh

#get cross compiler tool chain for raspberrypi
echo ""
echo "##############################"
echo "#    Get Cross Toolchain     #"
echo "##############################"
echo ""
mkdir rpi-toolchain
cd rpi-toolchain
git clone https://github.com/raspberrypi/tools.git ./
cd ../

#create staging dir for raspberrypi
echo ""
echo "##############################"
echo "#     Create RPi Staging     #"
echo "##############################"
echo ""
mkdir rpi-staging
cd rpi-staging
#wget tar file 
wget https://dl.dropboxusercontent.com/u/63484953/rpi-staging-arch-linux.tar.gz
tar xvzf rpi-staging-arch-linux.tar.gz ./
cd ../
