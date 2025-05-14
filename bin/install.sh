#!/bin/sh

set -e; \
    ARCH_NAME="$(uname -m)"; \
    url=; \
    case "${ARCH_NAME}" in \
        'amd64') \
            url='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz'; \
            ;; \
        'arm64') \
            url='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz'; \
            ;; \
        'aarch64') \
            url='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz'; \
            ;; \
        *) echo >&2 "error: unknown architecture: ${ARCH_NAME}"; exit 1 ;; \
    esac; \
    curl -kfsSL "${url}" -o nvim.tar.gz; \
    mkdir -p /opt/nvim; \
    tar -xzf nvim.tar.gz --directory /opt/nvim --strip-components 1; \
    rm nvim.tar.gz;

set -e; \
    mkdir -p /opt/jj; \
    url=;
    case "${ARCH_NAME}" in \
        'amd64') \
            url='https://github.com/jj-vcs/jj/releases/download/v0.29.0/jj-v0.29.0-x86_64-unknown-linux-musl.tar.gz'; \
            ;; \
        'arm64') \
            url='https://github.com/jj-vcs/jj/releases/download/v0.29.0/jj-v0.29.0-aarch64-unknown-linux-musl.tar.gz'; \
            ;; \
        'aarch64') \
            url='https://github.com/jj-vcs/jj/releases/download/v0.29.0/jj-v0.29.0-aarch64-unknown-linux-musl.tar.gz'; \
            ;; \
        *) echo >&2 "error: unknown architecture: ${ARCH_NAME}"; exit 1 ;; \
    esac; \
    curl -kfsSL "${url}" -o jj.tar.gz; \
    tar -xzf jj.tar.gz --directory /opt/jj --strip-components 1; \
    rm jj.tar.gz;

echo 'export PATH=$PATH:/opt/nvim/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/opt/nvim/bin' >> ~/.zshrc

echo 'export PATH=$PATH:/opt/jj' >> ~/.bashrc
echo 'export PATH=$PATH:/opt/jj' >> ~/.zshrc

rsync -a config/ ~/.config/
