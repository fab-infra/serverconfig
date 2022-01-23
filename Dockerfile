# Base image
ARG BASE_IMAGE
FROM $BASE_IMAGE

# Switch to root
USER 0

# Install Python if necessary
RUN python3 --version || ( apt-get -q update && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends gpg gpg-agent python3 python3-pip && rm -rf /var/lib/apt/lists/* )

# Install Ansible
RUN pip install --no-cache-dir ansible

# Switch to directory
WORKDIR /serverconfig

# Launch setup
ENTRYPOINT ["./setup.sh"]
