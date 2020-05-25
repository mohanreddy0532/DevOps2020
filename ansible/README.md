Working on Ansible @20FEB2020

Refer practicals 
https://gitlab.com/mohanreddy0532/devops
git add -A
-A
--all
--no-ignore-removal
Update the index not only where the working tree has a file matching <pathspec> but also where the index already has an entry. This adds, modifies, and removes index entries to match the working tree.

If no <pathspec> is given when -A option is used, all files in the entire working tree are updated (old versions of Git used to limit the update to the current directory and its subdirectories).
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

@47:00Mins
include_tasks: Includes a file with a list of tasks to be executed in the current playbook.
import_tasks: Imports a list of tasks to be added to the current playbook for subsequent execution.

To check SQL on remote machine :
mysql -u root -ppassword @1:10:20Mins

Robo-Shop=Reddis @1:11:00Mins.
/redis/main.yml @1:14:00Mins
=================================D45-2020-02-26-SESSION-31==========================================

12.Filters.yml @05:00Mins #To manipulate data
node --version @35:06Mins

Role:catalogue service @34:00Mins

clone-module:@38:00Mins

Ansible vault: @50:00Mins

ls -ltr /root/ROBO-SHOP/catalogue @1:07:00Mins

Update ROOT-DIR--->/roor/robo-shop@1:07

****Install NodeJS @1:09:00Mins****Wrong

Catalogue service started.
ps -ef| grep catalogue
root /bin/mode /root/ROBO-SHOP/catalogue/server.js
manual:systemctl start catlogue
=================================D45-2020-02-28-SESSION-32==========================================
After catalogue service, we went with diff. functions.
Calling function wit diff. values.So try to re-use the code
So copy nodeJS/main.yml to install.yml
copy part of catalogue/mail.yml to nodeJS/app-setup.yml
Import another role to catalogue/mail.yml from nodeJS
copy name catalogue/vars/main.yml from nodeJS/vars/main.yml

Role:cart service @12:00
cart/tasks/main.yml
for nodejs--->cart/meta/main.yml dependencies

Now call Application @17:05Mins
copy catalogue/tasks/main.yml to cart/tasks/main.yml

Cart service started.
ps -ef| grep service.js @21:10Mins
root /bin/mode /root/ROBO-SHOP/cart/server.js
manual:systemctl start cart

Role:Shipping service @21:00Mins
removed pre-reqs as we hv app-clone with vault pwd.
Require Java @25:00Mins

Create S3 bucket contains jar files.@30:00Mins
for S3-->D45-2020-02-17-SESSION-23 @57:00Mins
shipping/defaults/main.yml @32:00Mins
why defaults:to over ride the jar file.(to provide another URL)

rsyslog @40:00Mins
Role:Payment service-python---->@1:00:00Mins

=================================D45-2020-02-29-SESSION-33=================================
Ansible:
Continue.......Role:Payment service-python 

Role:Dispatch service @22:00Mins 
Role:Dispatch service @22:00Mins
&& = will execute a second command only if first one is successful @40:00Mins
=============================================***********===================================================

>>>>>>Online Book For Ansible: Ansible for DevOps /////#D45-2020-03-03-SESSION-35 @53:00Mins
