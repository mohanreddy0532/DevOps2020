Working on Ansible @20FEB2020
=============================================
Install Ansible-Server:

SSH Key setup for Ansible:
Install Ansible:
-------
#yum install ansible -y;
#ansible --version
-------
Creating Inventory:
ansible -i inventory all -m ping
ansible will Pick central cfg file if local is not available.  /etc/ansible/ansible.cfg
So create a local cfg file for daily use.cp /etc/ansible/ansible.cfg . 
u will get /home/USERName/ansible.cfg
host_key_checking=False--->enable not to ask yes/no in ssh
-------
ansible -i inventory all -m ping
ansible -i inventory all -u root -k -m ping------>root user/pwd
ansible -i inventory all -u centos --private-key=devops.pem -m ping------->centos user/pem key  D45-2020-02-20-SESSION-26@46:00Mins
-------
.pem file to .ppk--->For using in Putty D45-2020-02-20-SESSION-26@40Mins
---------
Create gitLab >>>mohanreddy>>>devops>>>ansible.
