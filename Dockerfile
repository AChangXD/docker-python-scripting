FROM mcr.microsoft.com/devcontainers/base:ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

USER vscode
WORKDIR /home/vscode

ENV NVM_DIR=/home/vscode/.nvm
RUN mkdir -p "$NVM_DIR" \
    && curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && bash -lc "source $NVM_DIR/nvm.sh && nvm install 22 && nvm alias default 22"

ENV PATH=/home/vscode/.local/bin:/home/vscode/.nvm/versions/node/v22.*/bin:${PATH}

RUN bash -lc "source $NVM_DIR/nvm.sh \
    && nvm use 22 \
    && npm config set prefix /home/vscode/.local \
    && npm i -g @openai/codex"

WORKDIR /workspaces