Working on Ansible @20FEB2020

Refer practicals 
https://gitlab.com/mohanreddy0532/devops
=============================================
Install Ansible-Server:

SSH Key setup for Ansible:

Install Ansible:
-------
yum install ansible -y;

ansible --version
-------
Creating Inventory:

ansible -i inventory all -m ping

ansible will Pick central cfg file if local is not available.  /etc/ansible/ansible.cfg

So create a local cfg file for daily use.cp /etc/ansible/ansible.cfg . 

u will get /home/USERName/ansible.cfg

host_key_checking=False--->enable not to ask yes/no in ssh
-------
ansible -i inventory all -m ping

ansible -i inventory all -u root -k -m ping------>root user/pwd :DevOps321

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
---------
To List all module installed in ansible:
#ansible-doc -l |wc -l

Check Ping module:
ansible all -m ping #to check ping module.
ansible all -m ping -o # o/p will be in single line
---------------------------------
Using shell module:

ansible all -m shell -a uptime
ansible all -m shell -a "uptime;df -h"
=============================================
Start with PlayBook for multiple Modules at a time:@D45-2020-02-20-SESSION-26@1:06:00Mins

Install:
ansible all -m yum -a "name=nginx state=present" -s ## -s=for SUDO
ansible all -m service -a "name=nginx state=started" -s
=======================================================
Create a sample playbook 01.sample.yml file
=======================================

#D45-2020-02-21-SESSION-27 @23:30Mins

Ansible Best Practices: 
https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#directory-layout
------------
Inventory Setup:@28Mins

To list all Hosts in Inventory:
#ansible -i inventory all --list-hosts

To list only DEV servers:
   In inventory file make a DEV list:
   [DEV]
   server 1
   server 2
#ansible -i inventory DEV --list-hosts

To list Group of groups servers:
   In inventory file make a list:#Group of groups 
   [grp1:children]
   DEV
   gen
#ansible -i inventory grp1 --list-hosts

To check DEV group servers shell command.
ansible -i inventory DEV -m shell -a uptime

01.Sample.yml  ------->>@14:00Mins

Ansible Playbooks creation,YML files.

Inventory Options:

XML,JSON,YAML

Yet another markup language (YAML)

YAML to JSON convertion: yq

=================================================================================
---------------------------#D45-2020-02-22-SESSION-28-----------------------------
Ansible PlayBooks:
02.play-layout.yml @11:49Mins

03.print.yml    @15:00Mins

04.Variables.yml @22:00Mins

ansible-playbook playbooks/04.variables.yml

Variable Priority order:
1. CLI 
2. tasks
3. vars_files 
4. vars_prompt 
5. vars 
6. variables from inventory , hosts 
7. variables from inventory , group 
--------------------------------------------------

##Create Project.yml  @54:00Mins
##Robo-shop=Mariabd

Copy Module:@54:00Mins
src:  dest:

Previliage escalations. @58:00Mins
become: yes # TO Enable SUDO

Creating Roles:@1:00:00Mins for structured data:
To use Roles it should comtain main.yml #https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html
Created main.yml under : #/home/mtallapu/Desktop/devops/ansible/playbooks/roles/sample/tasks/main.yml
ansible-playbook playbooks/06.roles.yml

Create mongoRepo: @1:07:00 Mins
/home/mtallapu/Desktop/devops/ansible/playbooks/roles/mongodb/tasks/main.yml
Update mongoDB role in project.yml
Create mongo.repo file in /home/mtallapu/Desktop/devops/ansible/playbooks/roles/mongodb/files

Start a Service :

-name: Start MongoDB
  service:
    name:  mongod
    state: started  
    enabled: yes
    
Check service on target server: sudo netstat -nltp
tcp        0      0 127.0.0.1:27017         0.0.0.0:*               LISTEN      2563/mongod

Verbose mode Tracing: ansible-playbook -vvvv playbooks/06.roles.yml    

=================================================================================

---------------------------#D45-2020-02-24-SESSION-29-----------------------------

LineIn File & BlockIn File @2:00Mins -------it will change complete line in a file.

Linein File--->Change entire single line
BlockIn File--change in a block at a time.

----

For change a particular work or port number Use: @17:00Mins

replace: 
   path: /tmp/mongod.conf
   regexp: "27017"
   replace: "27018" 

----------------------------------------------------------
LoadSchema for MongoDB @20:40 and @30:00Mins--->imp
For git

Create pre-reqs/tasks/main.yml role @27:40--->Imp

---------
Role dependencies:/mongod/meta/main.yml @29:00Mins

----
09.loop.yml @34:00Mins---to deal with multiple js files.


10-regisrtry.yml @45:00Mins
[centos@ip-172-31-32-65 ansible]$ ansible-playbook playbooks/10-register.yml


11-conditionals.yml @48:00Mins

/ansible/playbooks/roles/mongodb/tasks/schema.yml (to check mutile .js file exist or not) @59:00Mins


sudo service mongod start;
Error:Job for mongod.service failed because the control process exited with error code. See "systemctl status mongod.service" and "journalctl -xe" for details.
sudo systemctl status mongod.service
error:Failed to start.
rm -rf /tmp/mongodb-27017.sock

netstat -nltp;

cd /tmp/robo-shop/mongo
mongo #to enter DB
show dbs
> use users;
switched to db users
> db. dropDatabase()
{ "dropped" : "users", "ok" : 1 }
> 

>show dbs (it will dropped Db users)
--------------------------------------------------
Robo-shop=RabbitMQ @1:05:00Mins

create roles: rabbitmq/tasks/main.yml
netstat -lntp
tcp6       0      0 :::5672                 :::*                    LISTEN      4390/beam.smp 
=================================D45-2020-02-25-SESSION-30==========================================

Robo-shop=MYsql @3:00Mins

Install @15:00Mins
SetUp default root/pwd for one time@29:00Mins
/file/pass-reset.schema.sql @38:00Mins















=============================================***********===================================================

>>>>>>Online Book For Ansible: Ansible for DevOps /////#D45-2020-03-03-SESSION-35 @53:00Mins
