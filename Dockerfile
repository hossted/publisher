FROM debian:13-slim
RUN apt-get update
RUN apt -y install curl uuid-runtime jq git openssh-client wget unzip python3 python3.13-venv python3-pip wget awscli
RUN wget assets.hossted.com/etcdctl 2>/dev/null
RUN chmod +x etcdctl
RUN mv etcdctl /usr/local/bin
RUN apt -y install ansible 2>/dev/null
RUN ansible-galaxy collection install ansible.posix community.general --ignore-errors
RUN wget https://github.com/oracle/oci-cli/releases/download/v3.91.0/oci-cli-3.91.0.zip 2>/dev/null
RUN unzip oci-cli-3.91.0.zip >>/dev/null
RUN pip install oci-cli/oci_cli-3.91.0-py3-none-any.whl --break-system-packages --ignore-installed PyYAML
RUN curl -fsSL 'https://azurecliprod.blob.core.windows.net/$root/deb_install.sh' | bash
RUN curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
RUN tar -xf google-cloud-cli-linux-x86_64.tar.gz
RUN ./google-cloud-sdk/install.sh --quiet
RUN rm -rf google-cloud-cli-linux-x86_64.tar.gz
RUN rm oci-cli-3.91.0.zip
RUN rm -rf oci-cli-3.91.0
RUN echo PATH=$PATH:/google-cloud-sdk/bin >>/etc/environment
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*
