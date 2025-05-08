# 03 - Systemd Services

Define services to auto-start both your validator and the Web GUI.

## trac-store.service

Path: `/etc/systemd/system/trac-store.service`

```ini
[Unit]
Description=TRAC HyperMall Store (screen managed)
After=network.target

[Service]
ExecStart=/home/YOUR_USERNAME/Trac/my-msb/start_tracstore.sh
Restart=always
User=YOUR_USERNAME

[Install]
WantedBy=multi-user.target
```

## hypermall-gui.service

Path: `/etc/systemd/system/hypermall-gui.service`

```ini
[Unit]
Description=HyperMall Web GUI
After=network.target trac-store.service

[Service]
WorkingDirectory=/home/YOUR_USERNAME/Trac/hypermall-gui
ExecStart=/usr/bin/python3 /home/YOUR_USERNAME/Trac/hypermall-gui/app.py
Restart=always
User=YOUR_USERNAME

[Install]
WantedBy=multi-user.target
```

Enable and start both:

```bash
sudo systemctl daemon-reload
sudo systemctl enable trac-store.service hypermall-gui.service
sudo systemctl start trac-store.service hypermall-gui.service
```
