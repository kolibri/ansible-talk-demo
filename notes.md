NOTES:
What will you show:
    - local usage
    - loops with jinja
    - default values
    - privilige escalation
    - git repo thing
    - grouping hosts in inventory file
    - one playbook to rule them all
    - copy from local and remote machine
    - select by os (and other facts)
    - check option
    - services
    - templates

Put this into a story
    Set up your dev environment
        - Git
            Git module
            gitignore via remote file
            git config
        - Setup zsh
        - osx defaults

    Set two role dirs
        One for very small roles (one package related)
        One for use case roles

    Find out, how to repeat roles (vhost-thing)
        Must include them n times

            
    One good advanced example for conditions

    Tags


    Your Init Role, that will run with a different user
        And then will be included in the main site-yml




# Ansible
#Provision ALL the things

## What problems solves Ansible?

- You bought a new pc, and your partner still wants to do something this weekend (with you)
- You need a development vm
- Integrate the new Raspberry Pi in your cluster
- (And all the other scenarios, where provisioning may come handy)

## Something you should know

- Ansible is written in python (v2, not v3)
- No need to install ansible on your target machines!
- Configuration is done in YAML-Files
- You can use a subset of Jinja2 (almost the same as Twig) in your configuration

## Concepts (or vocalubar) of ansible

- inventory file
    - Contains hosts to provision
    - groups hosts
- role
    - A package/usecase specific configuration
    - should be reusable and independend
    - like "php", "dev-tools" or "workstation"
- playbook
    - describes a run configuration 
    - assigns roles to hosts/groups


## So, lets start

- Our target: Provision our development machine and vagrant box with same scripts
- Add the target hosts to your inventory file

    # hosts
    localhost ansible_connection=local
    vagrant.box ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

- Ping them to make shure ansible works

    ansible all -m ping

- Install git

    - apt: name=git state=latest

Final version:
    - name: install git with apt
      become: true
      apt: name={{ item }} state=latest
      with_items:
        - git






## Notes to bugs and some conclusions:

- Have one repository for all your ansible scripts

fatal: [vagrant.box] => Using a SSH password instead of a key is not possible because Host Key checking is enabled and sshpass does not support this.  Please add this host's fingerprint to your known_hosts file to manage this host.
->
When developing with vagrant, you can bypass host key checking with ssh'ing into the box with `ssh vagrant@vagrant.box` and not `vagrant ssh`. This will add the host to your local `~/.ssh/known_hosts`. The drawback is, that with every `vagrant destroy` the hosts entry in `known_hosts` will be invalid, and must be removed manualy


User module removes groups in OSX
https://github.com/ansible/ansible-modules-core/issues/2322

hostname module does not work on osx (darwin). Also not on arch, but this is bug

update ansible on osx (el capitan) with pip needs '--ignore-installed' flag
# sudo pip install --upgrade --ignore-installed ansible




### OSX Settings, you show in slides

#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
#defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

- name: write osx defaults
  osx_defaults: domain=com.apple.Safari key=IncludeInternalDebugMenu type=bool value=true state=present

