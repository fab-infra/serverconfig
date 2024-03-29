# Base image
ARG BASE_IMAGE
FROM $BASE_IMAGE

# Install updates
RUN if grep -q '^ID.*rhel' /etc/os-release; then yum -y update && yum install -y epel-release && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" && rm -rf /var/lib/apt/lists/*; fi

# Install Python
RUN if grep -q '^ID.*rhel' /etc/os-release; then yum -y install gpg python3 python3-pip && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends gpg gpg-agent python3 python3-pip && rm -rf /var/lib/apt/lists/*; fi

# Install Ansible
RUN if grep -q '^ID.*rhel' /etc/os-release; then yum -y install ansible && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends ansible && rm -rf /var/lib/apt/lists/*; fi

# Switch to directory
WORKDIR /serverconfig

# Launch setup
ENTRYPOINT ["./setup.sh"]
