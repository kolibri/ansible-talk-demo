run:
	ansible-playbook -i hosts site.yml 
init:
	ansible-playbook -i hosts site.yml --tags "init"

ping:
	ansible all -i hosts -m ping -vvv

osx:
	ansible-playbook -i hosts --limit=ansible-demo-osx.dev site.yml --skip-tags="debug"
ubuntu:
	ansible-playbook -i hosts --limit=ansible-demo-ubuntu.dev site.yml 
arch:
	ansible-playbook -i hosts --limit=ansible-demo-arch.dev site.yml 

#run with tags:
run-with-tags:
	ansible-playbook -i hosts site.yml --tags "debug"

run-step:
	ansible-playbook -i hosts site.yml --step

ansible-git-install:
	sudo apt-get update --yes
	sudo apt-get upgrade --yes
	sudo apt-get install git python-setuptools --yes
	git clone git://github.com/ansible/ansible.git ansible-git --recursive
	sudo easy_install pip
	sudo pip install paramiko PyYAML Jinja2 httplib2 six
#	source ./ansible-git/hacking/env-setup -q

ansible-git-update:
	git pull --rebase
	git submodule update --init --recursive

rebuild:
	sed '/ansible-demo-ubuntu.dev/d' ~/.ssh/known_hosts
	sed '/ansible-demo-osx.dev/d' ~/.ssh/known_hosts
	vagrant destroy -f
	vagrant up
	ansible-playbook -i hosts site.yml 

generate-password:
	python -c 'import crypt; print crypt.crypt("vagrant", "$6$SomeSalt")'