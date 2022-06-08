FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    && apt remove -y curl \
    && rm -rf /var/lib/apt/lists/*
EXPOSE 8080

