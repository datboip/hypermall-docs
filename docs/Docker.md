# 05 - Docker

Package everything into one container for zero‑install deployment.

## Build the image

From your repo root:

```bash
docker build -t hypermall-gui .
```

## Run the container

```bash
docker run -d \
  --name hypermall-gui \
  -p 5000:5000 \
  -v /path/on/host/hypermall_config.json:/app/hypermall_config.json \
  -v /path/on/host/logs:/tmp \
  hypermall-gui
```

- **`/path/on/host/hypermall_config.json`** → your local config file  
- **`/path/on/host/logs`** → folder to store `tracstore.log`

## Commands

- View logs: `docker logs -f hypermall-gui`  
- Stop: `docker stop hypermall-gui`  
- Remove: `docker rm hypermall-gui`  
