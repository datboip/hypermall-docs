# Docker

## Docker

Containerized deployment for your HyperMall validator and Web GUI.

***

### 🧱 Build the image

From the root of your repo:

```bash
docker build -t hypermall-gui .
```

***

### 🚀 Run the container

```bash
docker run -d \
  --name hypermall-gui \
  -p 5000:5000 \
  -v /path/on/host/hypermall_config.json:/app/hypermall_config.json \
  -v /path/on/host/logs:/tmp \
  hypermall-gui
```

* `/path/on/host/hypermall_config.json` → your Web GUI config
* `/path/on/host/logs` → folder to store `tracstore.log`

***

### 🧰 Commands

| Action         | Command                        |
| -------------- | ------------------------------ |
| View logs      | `docker logs -f hypermall-gui` |
| Stop container | `docker stop hypermall-gui`    |
| Remove         | `docker rm hypermall-gui`      |

***

Originally from: `docs/05-Docker.md`
