Working on Ansible @20FEB2020

Refer practicals 
https://gitlab.com/mohanreddy0532/devops
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

On AnsibleServer:

Create a config file under cd .ssh/config======>>>this will authenticate gitLab when u run git push commancd using devops.pem file.

chmod 600 .ssh/config ##Permissions must

cat config
Host *
   IdentityFile ~/devops.pem
   ---------------------



==========================================================================
D45-2020-02-20-SESSION-26@1:00:00Mins
Automate inventory file by editing ansible.cfg as below.

inventory       = /home/centos/devops/ansible/inventory

ansible all -u centos --private-key=~/devops.pem -m ping


Automate -u <User> by editing ansible.cfg as below.

remote_user = centos

ansible all --private-key=~/devops.pem -m ping

Automate Private-key by editing ansible.cfg as below.

private_key_file = /home/centos/devops.pem

ansible all -m ping
---------------------------------
Using shell module:

ansible all -m shell -a uptime

=============================================
Start with PlayBook for multiple Modules at a time:@D45-2020-02-20-SESSION-26@1:06:00Mins
=======================================================
Create a sample playbook 01.sample.yml file
=======================================

D45-2020-02-21-SESSION-27 @23:30Mins

Ansible Best Practices: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#directory-layout
------------
To list all Hosts in Inventory:

ansible -i inventory all --list-hosts

01.Sample.yml  @14:00Mins

Ansible Playbooks creation,YML files.

Inventory Options:

XML,JSON,YAML

Yet another markup language (YAML)

YAML to JSON convertion: yq

=================================================================================
---------------------------D45-2020-02-22-SESSION-28-----------------------------
Ansible PlayBooks:
02.play-layout.yml @11:49Mins
03.print.yml    @15:00Mins
04.Variables.yml @22:00Mins

ansible-playbook playbooks/04.variables.yml

Variable Priority order:
## 1. CLI 
## 2. tasks
## 3. vars_files 
## 4. vars_prompt 
## 5. vars 
## 6. variables from inventory , hosts 
## 7. variables from inventory , group 
--------------------------------------------------

Create Project.yml  @54:00Mins
Robo-shop=Mariabd

Copy Module:@54:00Mins
src:  dest:

Previliage escalations. @58:00Mins
become: yes #TO Enable SUDO

Creating Roles:@1:00:00Mins for structured data:
To use Roles it should comtain main.yml #https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html
Created main.yml under : #/home/mtallapu/Desktop/devops/ansible/playbooks/roles/sample/tasks/main.yml
ansible-playbook playbooks/06.roles.yml

Create mongoRepo: @1:07:00 Mins
/home/mtallapu/Desktop/devops/ansible/playbooks/roles/mongodb/tasks/main.yml
Update mongoDB role in project.yml
Create mongo.repo file in /home/mtallapu/Desktop/devops/ansible/playbooks/roles/mongodb/files
----
Start a Service :

-name: Start MongoDB
  service:
    name:  mongod
    state: started  
    enabled: yes

Verbose mode: ansible-playbook -vvvv playbooks/06.roles.yml    
=================================================================================
---------------------------D45-2020-02-24-SESSION-29-----------------------------

LineIn File & BlockIn File @2:00Mins -------it will change complete line in a file.
Linein File--->Change entire single line
BlockIn File--change in a block at a time.
----
For change a particular work or port number Use: @17:00Mins
replace:
          path: /tmp/mongod.conf
          regexp: "27017"
          replace: "27018" 
---------
LoadSchema for MongoDB @20:40

Create pre-reqs/tasks/main.yml role @@27:40

Role dependencies:/mongod/meta/main.yml @29:00Mins