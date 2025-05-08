# 02 - Start/Stop Scripts

Scripts to launch your Pear validator in a detached screen session and log output.

## start_tracstore.sh

```bash
#!/bin/bash

echo "[start script] Running at $(date)" >> /tmp/tracstore.log
/usr/bin/screen -S tracstore -dm bash -c '\
  source ~/.nvm/nvm.sh && \
  export PATH=$HOME/.config/pear/bin:$PATH && \
  pear run \
    pear://YOUR_PEAR_URL \
    store1 2>&1 | tee -a /tmp/tracstore.log'
```

## stop_tracstore.sh

```bash
#!/bin/bash
pkill -f tracstore
```

Make both executable:

```bash
chmod +x start_tracstore.sh stop_tracstore.sh
```
