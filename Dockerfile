
ARG NODE_VERSION
FROM bitnoize/node:${NODE_VERSION}

ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    # GitHub
    echo "Package: *"         >> /etc/apt/preferences.d/90github-cli; \
    echo "Pin: release o=gh"  >> /etc/apt/preferences.d/90github-cli; \
    echo "Pin-Priority: 1000" >> /etc/apt/preferences.d/90github-cli; \
    wget -q -O- "https://cli.github.com/packages/githubcli-archive-keyring.gpg" > \
        /usr/share/keyrings/githubcli-archive-keyring.gpg; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > \
        /etc/apt/sources.list.d/github-cli.list; \
    # Debian packages
    apt-get update -q; \
    apt-get install -yq \
        socat openssh-client \
        fish curl links neovim \
        git gh \
        tmux tmux-plugin-manager; \
    # Change Shell
    usermod -s /usr/bin/fish node; \
    # Clean-up
	  rm -rf /var/lib/apt/lists/*; \
    # Smoke tests
    socat -V; \
    ssh -V; \
    fish -v; \
    curl -V; \
    links -version; \
    nvim -v; \
    git --version; \
    gh --version; \
    tmux -V

WORKDIR /home/node
VOLUME /home/node

ENTRYPOINT ["entrypoint.sh"]
CMD ["fish"]

