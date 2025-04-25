# Ansible for provisioning a fresh homeserver installation

Main goal of this repo is to provide me a simple way to provision test machines with commonly used tools and basic security.

This repo was created to provision machines hosted on [mikr.us](https://mikr.us/).

## How to run

Requirement to run this project:
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (duh)
- SSH connection to your machine

I prefer to use [pyenv](https://github.com/pyenv/pyenv) to manage all my python environments.

1. Create `.ansible_inventory` pointing to your server (more about [inventories](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html))
```
[servers]
homeserver ansible_port=1234 ansible_host=localhost ansible_user=root hostname=homeserver

[servers:vars]
config_system_locale=en_US.UTF-8
config_system_language=en_US.UTF-8
config_system_timezone=Europe/Warsaw
```
2. Run [playbook](https://docs.ansible.com/ansible/latest/network/getting_started/first_playbook.html)
```
ansible-playbook playbook.yml
```

## What you can expect

List of side effects:
- Upgrade distro
- Instal basic packages (curl, git, zsh, etc.)
- Configure basics of the system (locale, hostname, default shell)
- Set up UFW (Universal Firewall)
- Install and configure logwatch and docker
- Install user customizable packages (support for apt packages and script installers)
- Create and configure users
- Harden OS with [devsec.hardening](https://github.com/dev-sec/ansible-collection-hardening)

## Customization

Most parameters are customizable in playbook.yml

### Packages

Role `install` consumes variables defined for the role execution.

#### User packages

Variable `install_user_packages` simply consumes list of either string or objects.

| Attribure | Optional | Describtion |
|-|-|-|
| pkg | mandatory | Name of the package consumed by `apt install`, filled in case string is passed |
| apt_repo_url | optional | Link to the custom apt repository. Will be added to the apt source.list |
| key_url | optional (mandatory with apt_repo_key) |  Link to the key used to sing the custom apt repository. Key will be added to the apt keyring. |

#### User tool via script

Some tools are avaliable through installation scripts. For omnipotency, role will check if executable exist in the system.

| Attribure | Optional | Describtion |
|-|-|-|
| url | mandatory | Url with the script, needs to be downloadable link. |
| args | optional | Arguments passed to the script. |
| executable | mandatory | Name of the produced executable. For omnipotency the role check if executable exists. |

### Users

Users are configureg with [l3d.users package](https://galaxy.ansible.com/ui/repo/published/l3d/users/). Please consult documentation for all the parameters.

If you use this script, you will probably want to update `pubkeys:` in the `playbook.yml`.

For now the root user is not turned off! Disable it yourself if you want.

### Mikrus specific role

For now the only mikr.us specific role is pusher for logwatch. By default logwatch will be run every sunday creating report. This role adds pushing those reports to pusher service.

To disable mikrus role, please comment `- mikrus` from `playbook.yml`.
