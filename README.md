# Server config Ansible playbook

This repository contains an [Ansible](https://docs.ansible.com/ansible/latest/index.html) playbook to setup server configuration.

## Execution

To update and execute the `serverconfig.yml` playbook locally for the current machine, run:

```
./update.sh
./setup.sh
```

## Testing

The playbook can be tested in an isolated environment with [Docker](https://docs.docker.com/engine/install/) and [Docker Compose](https://docs.docker.com/compose/install/). Run one of the following commands depending on the target OS:

```
./test.sh debian12
./test.sh debian13
./test.sh opensuse160
./test.sh opensusetw
./test.sh rocky9
./test.sh ubuntu2204
```

Tests are run against a `localhost` host in the `test` group.

Note that some steps (e.g. enabling services) cannot be run in Docker and will be skipped.

## Roles

The following roles are available in this repository:
- `base`: common packages and system configuration
- `docker`: Docker daemon setup
- `firewall`: firewall configuration
- `homeserver`: services for home automation, file sharing and media center
- `k8s`: Kubernetes master, control plane or worker node
- `kodi`: Kodi media center
- `openvpn`: OpenVPN server or client
- `otelcol`: OpenTelemetry Collector

Role names can be used as tags to include/exclude some of them during execution, for example:

```
./setup.sh --tags base
./setup.sh --skip-tags k8s
```

## Vault

As a [best practice](https://docs.ansible.com/projects/ansible/latest/tips_tricks/ansible_tips_tricks.html#keep-vaulted-variables-safely-visible), secret variables should be named with a `vault_` prefix, placed in an encrypted `vault.yml` file and referenced from a `vars.yml` file.

The Vault password must be specified in a `vault.password` file at the root of this repository.

To encrypt/view/decrypt files, use one of the following commands:

```
./vault.sh encrypt inventory/host_vars/<host>/vault.yml
./vault.sh view inventory/host_vars/<host>/vault.yml
./vault.sh decrypt inventory/host_vars/<host>/vault.yml
```
