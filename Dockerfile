FROM debian:13-slim
ENV PATH=$PATH:/google-cloud-sdk/bin
RUN apt-get update && \
    apt -y install curl uuid-runtime jq git openssh-client wget unzip python3 python3.13-venv python3-pip wget awscli && \
    wget assets.hossted.com/etcdctl 2>/dev/null && \
    chmod +x etcdctl && \
    mv etcdctl /usr/local/bin && \
    apt -y install ansible 2>/dev/null && \
    ansible-galaxy collection install ansible.posix community.general --ignore-errors && \
    wget https://github.com/oracle/oci-cli/releases/download/v3.91.0/oci-cli-3.91.0.zip 2>/dev/null && \
    unzip oci-cli-3.91.0.zip >>/dev/null && \
    pip install oci-cli/oci_cli-3.91.0-py3-none-any.whl --break-system-packages --ignore-installed PyYAML && \
    curl -fsSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | bash && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz && \
    tar -xf google-cloud-cli-linux-x86_64.tar.gz && \
    ./google-cloud-sdk/install.sh --quiet && \
    rm -rf google-cloud-cli-linux-x86_64.tar.gz && \
    rm oci-cli-3.91.0.zip && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf ./oci-cli/*
