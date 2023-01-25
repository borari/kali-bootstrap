# Kali Bootstrapper w/ Ansible
This script will install Ansible on a fresh Kali machine, then download and execute the borari.pentesting_collection from Ansible Galaxy.

The collection installs and configures most of the tools I have been using while participating in CTFs, HTB, PG, and the PWK labs. There are some tweaks for hardening, personalization, etc.

I wanted to be able to sit down on a fresh VM and have all my tools and preferred environment set up easily. This script allows for that with a single command after cloning.

The Ansible Galaxy collection is built to only use `sudo` for required tasks, and will ask for the `sudo` password prior to execution. All user configuration will occur in the context of the user executing the script. The How To Use section below will work while running as root, kali, or any other user.

How To Use
-------

- Clone the repo
        ```bash
        git clone https://github.com/borari/kali-bootstrap.git
        ```
- Run the deploy script
        ```bash
        cd kali-bootstrap-ansible
        ./deploy-kali.sh
        ```

Optional Instructions
-------

These instructions are not necessary. They are included in case you want to run as root on Kali but don't want to commit the following steps to memory.

- Log in with the default Kali installation
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
- Log in as root
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

License
-------

MIT
