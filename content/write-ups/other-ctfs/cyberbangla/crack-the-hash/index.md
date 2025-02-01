---
title: "Crack The Hash | Crypto"
date: 2025-01-18T00:00:56+06:00
draft: false
tags: ["writeups", "cyberbangla", "ctf"]
categories: ["CTF"]
---
## CTF NAME: Crack The Hash
**Point:** 120  
**Category:** Crypto  
**Description:**  
It will help You — https://github.com/F3LUD4/Wordlists

A strange code has been discovered, left behind by an unknown entity. It holds a vital secret, but its true meaning is locked away. Can you solve the puzzle and reveal the hidden flag? The challenge awaits.

http://\<IP>:3333/

**Flag:** CBCTF{n0t_an0th3r_rAnd0m_ch4r4ct3r_p4ssw0rd}

**Solve:**  
On the webpage, there is a password input field.  

![Web page only with password Input field](https://miro.medium.com/v2/resize:fit:640/format:webp/1*5fyFSiH4B9pa-vGfu89s6g.png)

Then I opened the page source. In the bottom there is a comment “<! — see ?debug for source →”  
  
![Page source of the web page](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*uRnqoD3L_I08Fc0mjbi2oQ.png)  

Then I added “/?debug” in the URL. And then I found a hash.  

![/?debug page](https://miro.medium.com/v2/resize:fit:828/format:webp/1*cIBQZIBC_RJIjqFbTPZhpg.png)

The hash is labeled with **MD5**.

**Hash:** 6be5628a3215ec5a19aaf6a853a3b385

A link to the wordlist is attached to the CTF description. I downloaded the wordlist and tried md5 decryption with John The Ripper.

At the start, I created a text file of the hash. John The Ripper required a Txt file.  

![creating a hash file using echo](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*qrK8A5h_Ja9DdgS4miXYXg.png)  

And then I cracked the hash with John The Ripper.  

![craking using jhon the ripper](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*dcqUWYlGJ-T18bSdpreE1w.png)  

**Command:** john –format=raw-md5 –wordlist=<wordlist path> hash.txt

The password is “52_mahfuj”. Then I input it into the password field. And I got the flag.  

![Exposed Flag](https://miro.medium.com/v2/resize:fit:750/format:webp/1*c15RdqFt54N13vuLRfX6Gg.png)  

---