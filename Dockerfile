# Base image
ARG BASE_IMAGE
FROM $BASE_IMAGE

# Switch to root
USER 0

# Install updates
RUN if grep -q '^ID.*rhel' /etc/os-release; then yum -y update && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" && rm -rf /var/lib/apt/lists/*; fi

# Install Python if necessary
RUN python3 --version || \
    if grep -q '^ID.*rhel' /etc/os-release; then yum -y install gpg python3 python3-pip && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends gpg gpg-agent python3 python3-pip && rm -rf /var/lib/apt/lists/*; fi

# Install Ansible
RUN export LANG=$(locale -a | grep -i utf | head -n 1) && \
    export LC_ALL=$LANG && \
    python3 -m pip --version || python3 -m ensurepip && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir ansible

# Switch to directory
WORKDIR /serverconfig

# Launch setup
ENTRYPOINT ["./setup.sh"]
