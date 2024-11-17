#!/bin/bash

sudo apt update > /dev/null

sudo apt full-upgrade > /dev/null

echo "Installing openssl if not exixts..."

which openssl

if [ $? -ne 0 ]; then
    sudo apt install openssl -y
fi

sleep 1

echo "Installing systemd-container-manager if not exixts..."

which systemd-container

if [ $? -ne 0 ]; then
    sudo apt install systemd-container -y
fi

sleep 1

echo "Installing debootstrap if not exixts..."

which debootstrap

if [ $? -ne 0 ]; then
    sudo apt install debootstrap -y
fi