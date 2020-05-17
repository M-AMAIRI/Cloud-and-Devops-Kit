### Deploy e-commerce application with Ansible - Hand on Tutorial 

This is a sample e-commerce application built for learning purposes 
created by kodekloudhub . please see this 
[link](https://github.com/kodekloudhub/learning-app-ecommerce) for the 
source code and for manual installation :


Here's how to deploy it on CentOS systems with Ansible step by step .

### Introduction :

as shown on the previous 
[link](https://github.com/kodekloudhub/learning-app-ecommerce) 
E-commerce Web site it’s a LAMP Application , so we need to automate the 
deploy.

E-commerce Web site it’s a LAMP Application the installation can be done 
manually as mentioned in the 
[link](https://github.com/kodekloudhub/learning-app-ecommerce)  through 
commands on the system terminal, but the goal of this project is to  we 
need to automate the deploy through ansible on several servers or only 
one server


installation Steps :

•	Install Firewall : to identify a systeme Linux like centos 

•	Install a server , Install httpd , configure httpd , configure 
firewall , start httpd

•	Install Database : Install MariaDB , configure Mariadb , start 
Mariadb, configure Firewall , configure database and then load data

•	Install php : configure code and installing other requirements


#### Inventory File :

The Ansible inventory file defines the hosts and groups of hosts upon 
which commands, modules, and tasks in a playbook operate. The file can 
be in one of many formats depending on your Ansible environment and 
plugins.


```
target1 ansible_host=192.168.2.23 ansible_ssh_pass=osboxes.org
target2 ansible_host=192.168.2.24 ansible_ssh_pass=osboxes.org

```

to establish ssh connectiviy between your controller and targets systems 
we need a inventory file ansible ,
it can group several servers or groups on the same file .

its contain a list of server and assigned with alias.
ansible_host is a inventory parametre to define the DNS or the IP of the 
target serve .
and we can also define the type of connectivity of the target server by 
ansible_connection parameter such as ssh , winrm , ssh .. .
ansible_user we can define the user name of the session and 
ansible_ssh8pass to define the password for the access .

here is an example :
Alias	Host	              Connection	User	         
Password
db1	server4.company.com	Windows	    administrator	
Password123!
web1	server1.company.com	SSH	         root    	
Password123!  

| Alias | Host	        | Connection	  | User | Password |
| :---:   | :-: | :-: | :-: | :-: |
|db1|	server4.company.com|	Windows	|    administrator|	
Password123!|
|web1|	server1.company.com|	SSH	|         root   | 	
Password123! | 

```
db1 ansible_host=server4.company.com ansible_connection=winrm 
ansible_user=administrator ansible_password=Password123!
web1 ansible_host=server1.company.com ansible_connection=ssh 
ansible_user=root ansible_ssh_pass=Password123!
```

in our case we have just two server target1 and target2 in our 
Inventory.txt file:
```
target1 ansible_host=192.168.2.23 ansible_ssh_pass=osboxes.org
target2 ansible_host=192.168.2.24 ansible_ssh_pass=osboxes.org
```

to test your Inventory file just write this command of ping test :

```sh
ansible target1 -m ping -i Inventory.txt
```
and the ping should return a SUCESS json output on the terminal 



### ansible playbooks :
is a stup of actions or a list of command defined on one file , actions 
may be Deploy on a defined list or group of servers or for setup network 
configuration , installation/configure database , run a script , install 
packages , restart or shutdown ... .

Ansible plybooks is a single yaml file define a setup of play ( a set of 
activities tasks to be run on hosts )

here an example :
```
-
    name: 'Execute two commands on web_node1'
    hosts: boston_nodes
    tasks:
        -
            name: 'Execute a date command'
            command: date
        -
            name: 'Execute a command to display hosts file'
            command: 'cat /etc/hosts'
```


so for our project we will create our playbook to run and automate a 
list of command to deply the E-comerce application :


```

-
 name: check connectivity
 hosts: all

 tasks:
  - name: Installation and Enable firewalld
    service: name=firewalld state=started enabled=yes


  - name: Installation MariaDB mariadb-server
    yum:
      name: mariadb-server

  - name: create file mycnf
    file:
      path: /etc/my.cnf
      state: touch

  - name: Installation MariaDB - Start Service
    service:
      name: mariadb
      state: started

  - name: Installation MariaDB -  systemctl enable mariadb
    command: systemctl enable mariadb

  - name: firewall-cmd 1
    command: firewall-cmd --permanent --zone=public --add-port=3306/tcp

  - name: firewall-cmd 2
    command: firewall-cmd  --reload

  - name: Reload firewall-cmd
    command: sudo firewall-cmd --reload


  - name: Import ecomdb
    shell: mysql ecomdb < dump.sql

  - name: install httpd
    yum:
      name: httpd

  - name: install php
    yum:
      name: php

  - name: install php-mysql
    yum:
      name: php-mysql

  - name: install package
    command: firewall-cmd --permanent --zone=public --add-port=80/tcp

  - name: reload
    command: firewall-cmd --reload

  - name: create file httpd.conf
    file:
      path: /etc/httpd/conf/httpd.conf
      state: touch

  - name: start httpd
    command: service httpd start

  - name: start httpd
    command: systemctl enable httpd

  - name: install git
    command: yum install -y git

  - name: clone to repository
    command: git clone 
https://github.com/kodekloudhub/learning-app-ecommerce.git 
/var/www/html/


```

on dump.sql file i made some change in order to check if mysql database 
or already exists before creation to avoid any kind of error .

```
CREATE DATABASE IF NOT EXISTS ecomdb;
CREATE USER  IF NOT EXISTS 'ecomuser'@'localhost' IDENTIFIED BY 
'ecompassword';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
FLUSH PRIVILEGES;
USE ecomdb;
CREATE TABLE IF NOT EXISTS products (id mediumint(8) unsigned NOT NULL 
auto_increment,Name varchar(255) default NULL,Price varchar(255) default 
NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) 
AUTO_INCREMENT=1;

INSERT INTO products (Name,Price,ImageUrl) VALUES 
("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone 
Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");

```

#### Run command playbook :
```
 ansible-playbook Playbook.yaml -i inventory.txt
```


#### Architecture for a Node Deployment

We can deploy on the same node ( on the same server  ) or we can deploy 
on model-multi node , it's Just the same things just a difference in 
configuration on the connectivity and of course with some changes in the 
inventory file and the playbook file of the ansible .

                                                                                    
-- M-AMAIRI 

