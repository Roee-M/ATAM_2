#!/bin/bash

echo
echo '[*] Starting QEMU'
echo

sudo qemu-system-x86_64 -kernel /boot/vmlinuz-`uname -r` -initrd /boot/initrd.img-`uname -r` -m 1024 -hda filesystem.img -append "root=/dev/sda single console=ttyS0"  -nographic
