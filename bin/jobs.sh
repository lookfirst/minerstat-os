#!/bin/bash
exec 2>/dev/null
echo "Running Clean jobs.."
find '/home/minerstat/minerstat-os' -name "*log.txt" -type f -delete
echo "Log files deleted"
sudo dmesg -n 1
sudo apt clean
# Fix Slow start bug
sudo systemctl disable NetworkManager-wait-online.service
# Nvidia PCI_BUS_ID
sudo rm /etc/environment
sudo cp /home/minerstat/minerstat-os/core/environment /etc/environment
export CUDA_DEVICE_ORDER=PCI_BUS_ID
# libc-ares2
sudo apt-get --yes --force-yes install libc-ares2 | grep "install"
# Max performance
#export GPU_FORCE_64BIT_PTR=1 #causes problems
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100
export GPU_MAX_HEAP_SIZE=100
# .bashrc
sudo cp -fR /home/minerstat/minerstat-os/core/.bashrc /home/minerstat
# rocm (for later usage)
# export HSA_ENABLE_SDMA=0
