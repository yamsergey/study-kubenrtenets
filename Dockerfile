FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    iproute2 \
    iptables \
    conntrack \
    socat \
    ebtables \
    sudo \
    uidmap \
    bash \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Install Minikube
RUN curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
    install -m 0755 minikube-linux-amd64 /usr/local/bin/minikube && \
    rm minikube-linux-amd64

# Create a user and set up passwordless sudo
RUN useradd -ms /bin/bash minikube && \
    echo "minikube ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the minikube user
USER minikube
WORKDIR /home/minikube

# Start with a shell
CMD ["/bin/bash"]
