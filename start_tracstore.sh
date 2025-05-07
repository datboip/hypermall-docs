#!/bin/bash

echo "[start script] Running at $(date)" >> /tmp/tracstore.log
/usr/bin/screen -S tracstore -dm bash -c '\
  source /home/rick/.nvm/nvm.sh && \
  export PATH=$HOME/.config/pear/bin:$PATH && \
  pear run \
    pear://obx9frmsfnohjap1743nr66645hb4gcrwiomegcq49irmogp49jy \
    store1 2>&1 | tee -a /tmp/tracstore.log'
