---
title: "FLAG | Steganography"
date: 2025-01-18T00:00:51+06:00
draft: false
tags: ["writeups", "cyberbangla", "ctf"]
categories: ["CTF"]
---
## CTF NAME: FLAG
**Point:** 30  
**Category:** Steganography  
**Description:**  
There are Multiple Flag find the actual one

**Attachment:** A jpg file.

**Flag:** CBCTF{Y0ur_F1r5t_Fl4G}  

**Solve:**  
At first I run “exiftool“ to view Exif metadata and found a secret key.

![](https://miro.medium.com/v2/resize:fit:828/format:webp/1*9rtk47ddBW0IyBOELFweCw.png)  

The secret key: `2dc5Tyc6kKNO2rCW9c2q90jwtVQoQf`  

I gave it to “Dcode.fr” to know about the cipher text.  

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*x8pF9ZZLSJ_ThzB7opTV8A.png)  

It is Base62. Then I decoded it.  

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*EdSDeJbi0vnX2XuWxY4MkA.png)  

And Then I got the flag.

Maybe there are multiple flags as the description said, but I got it on my first try. Hehe.  

---

