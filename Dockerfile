# Base image
ARG BASE_IMAGE
FROM $BASE_IMAGE

# Install updates
RUN if grep -q '^ID.*rhel' /etc/os-release; then yum -y update && yum install -y epel-release && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" && rm -rf /var/lib/apt/lists/*; \
    elif grep -q '^ID.*suse' /etc/os-release; then zypper -n update && zypper clean -a; fi

# Install Python
RUN if grep -q '^ID.*rhel' /etc/os-release; then yum -y install gpg python3 python3-pip python3-libselinux && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends gpg gpg-agent python3 python3-pip && rm -rf /var/lib/apt/lists/*; \
    elif grep -q '^ID.*suse' /etc/os-release; then zypper -n install gpg2 hostname python3 python3-pip && zypper clean -a; fi

# Install Ansible
RUN if grep -q '^ID.*rhel' /etc/os-release; then yum -y install ansible && yum clean all; \
    elif grep -q '^ID.*debian' /etc/os-release; then apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends ansible && rm -rf /var/lib/apt/lists/*; \
    elif grep -q '^ID.*suse' /etc/os-release; then zypper -n install ansible && zypper clean -a; fi

# Switch to directory
WORKDIR /serverconfig

# Launch setup
ENTRYPOINT ["./setup.sh"]
