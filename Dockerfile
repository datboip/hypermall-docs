FROM ubuntu:22.04

# Install system deps
RUN apt update && apt install -y \
    curl git screen \
    python3 python3-pip python3-venv \
    npm

# Install NVM & Node.js
ENV NVM_DIR /root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install 18 && \
    npm install -g pear
ENV PATH $NVM_DIR/versions/node/v18.17.1/bin:$PATH

# Copy scripts, config, and app
WORKDIR /app
COPY docs/ /app/docs/
COPY start_tracstore.sh stop_tracstore.sh /app/
COPY app.py /app/
COPY templates/ /app/templates/
COPY README.md /app/
COPY hypermall_config.json /app/

# Python deps
RUN pip3 install flask

EXPOSE 5000

CMD bash -c "chmod +x /app/start_tracstore.sh /app/stop_tracstore.sh && \
  /app/start_tracstore.sh && python3 /app/app.py"
