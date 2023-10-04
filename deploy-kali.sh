#!/usr/bin/env sh

echo "ICAgIF9fIF9fICAgICAgX19fICAgIF9fICAgIF8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAvIC8vXy9fX18gXy8gKF8pICAvIC8gICAoXylfX18gIF9fICBfX18gIF9fICAgICAgICAgICAgICAgICAgICAgCiAgLyAsPCAvIF9fIGAvIC8gLyAgLyAvICAgLyAvIF9fIFwvIC8gLyAvIHwvXy8gICAgICAgICAgICAgICAgICAgICAKIC8gL3wgLyAvXy8gLyAvIC8gIC8gL19fXy8gLyAvIC8gLyAvXy8gLz4gIDwgICAgICAgICAgICAgICAgICAgICAgIAovXy8gfHx8fF8sXy9fL18vICAvX19ffHwvXy9fLyAvfHxcX18sXy9fL3xffCAgICAgICAgICAgICAgICAgICAgICAgCiAgIC8gX18gKV9fX18gIF9fX18gIC8gL19fX19fXy8gL19fX19fX19fX18gX19fX18gIF9fX18gIF9fXyAgX19fX18KICAvIF9fICAvIF9fIFwvIF9fIFwvIF9fLyBfX18vIF9fLyBfX18vIF9fIGAvIF9fIFwvIF9fIFwvIF8gXC8gX19fLwogLyAvXy8gLyAvXy8gLyAvXy8gLyAvXyhfXyAgKSAvXy8gLyAgLyAvXy8gLyAvXy8gLyAvXy8gLyAgX18vIC8gICAgCi9fX19fXy9cX19fXy9cX19fXy9cX18vX19fXy9cX18vXy8gICBcX18sXy8gLl9fXy8gLl9fXy9cX19fL18vICAgICAKICAgICAgICAgICAgICBfXyAgIF9fXyAgICAgICAgICAgICAgIF8gX18vXy8gX18vXy8gICAgICAgICAgICAgICAgIAogXyAgICAgIF9fICBfL18vICAvICAgfCAgX19fXyAgX19fX18oXykgL18gIC8gL19fICAgICAgICAgICAgICAgICAgCnwgfCAvfCAvIC9fL18vICAgLyAvfCB8IC8gX18gXC8gX19fLyAvIF9fIFwvIC8gXyBcICAgICAgICAgICAgICAgICAKfCB8LyB8LyAvL18vICAgIC8gX19fIHwvIC8gLyAoX18gICkgLyAvXy8gLyAvICBfXy8gICAgICAgICAgICAgICAgIAp8X18vfF9fL18vICAgICAvXy8gIHxfL18vIC9fL19fX18vXy9fLl9fXy9fL1xfX18vICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK" | base64 -d

if ! command -v ansible >/dev/null; then
    echo "[+] Installing Ansible"
    sudo apt-get install ansible
    if [ $? -gt 0 ]; then
        echo "[!] Error occurred when attempting to install Ansible."
        exit 1
    fi
fi

echo -e "\n[+] Installing required Ansible collections\n"
ansible-galaxy collection install --upgrade borari.pentesting_collection
if [ $? -gt 0 ]; then
    echo "[!] Error occurred when attempting to install Ansible collections."
    exit 1
fi

echo -e "\n[+] Running Kali bootstrap playbook\n"
# if targeting xubuntu, uncomment the line below
#~/.local/bin/ansible-playbook borari.pentesting_collection.xubuntu.yml -i ~/.ansible/collections/ansible_collections/borari/pentesting_collection/playbooks/inventory/xubuntu -e 'target=xubuntu' --ask-become-pass
# if targeting kali, uncomment the line below
ansible-playbook borari.pentesting_collection.kali.yml -i ~/.ansible/collections/ansible_collections/borari/pentesting_collection/playbooks/inventory/kali -e 'target=kali' --ask-become-pass --vault-id ~/.ansible_password
if [ $? -gt 0 ]; then
    echo "[!] Error occurred during playbook run."
    exit 1    
fi

echo "[!] Finished"
