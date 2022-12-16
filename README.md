# Kali Bootstrapper w/ Ansible
>  Automation is our next year High Priority Objective, but we can't send commands to remote systems...

These playbooks install most of the tools I have been using on Kali while participating in CTFs, HTB, PG, and the PWK labs. There are some tweaks for hardening, personalization, etc. I wanted to be able to sit down on a fresh VM and have everything set up in a way that I am immdediately comfortable with. Since I'm the only one using this, the "How To" section below will include the steps I use when setting up a Kali box, ie as root etc.

How to use
-------

- Install Kali using the default install. This can be a VM image, VM installed from iso, bare-metal, or anything else
- Log in with the default 'kali/kali' credentials
- Ensure Kali is fully upgraded
    ```bash
    sudo apt update
    sudo apt upgrade
    sudo apt dist-upgrade
    ```
- Enable the root account
	```bash
	sudo passwd root
	```
- Reboot the system
    ```bash
    sudo reboot now
    ```
- Log in with user root
- Enable root login over SSH, then enable/start the SSH server
	```bash
	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	systemctl enable ssh
	systemctl start ssh
	```
- Remove user Kali
	```bash
	userdel -r kali
	```
- Create ssh-key and echo it to authorized_hosts
	```bash
	ssh-keygen
	cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
	```
- Clone the repo
	```bash
	git clone https://github.com/borari/kali-bootstrap.git 
	```
- Run the deploy script
	```bash
	cd kali-bootstrap-ansible
	./deploy-kali.sh
	```

Author
-------
- borari

- iesplin (fork source: https://github.com/iesplin/ansible-playbook-kali)

License
-------

MIT
