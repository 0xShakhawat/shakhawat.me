---
title: "Forbidden | Web"
date: 2025-01-18T00:00:52+06:00
draft: false
tags: ["writeups", "cyberbangla", "ctf"]
categories: ["CTF"]
---
## CTF NAME: Forbidden
**Point:** 275 (dynamic point)  
**Category:** Web  
**Description:**  
Hackers love forbidden things

http://\<IP>:4041/

**Flag:** CBCTF{d0n7_4fr41d_0f_3ncryp7ed_c00ki35}

**Solve:**  
This was an interesting one. I struggled a lot and learned a lot. It took more than 2 hours to solve. And It is worth the time.

The web is just a blank page. The response of the page is 403 Forbidden.  

![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*T-B5KPGExPjXrxHFEEjW-w.png)  

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZoRRe0PxwrWCMUj2gGAjWQ.png)  

I followed and tried what I knew and everything mentioned on **HackTricks**’s “**403 & 401 Bypasses**” page. But I can’t solve the challenge.

Then I have done a bunch of random things. Then I played with cookie, after done some things, I noticed the cookie value looks like a hash.  

![](https://miro.medium.com/v2/resize:fit:828/format:webp/1*TUoAIRkdjHEzd3vhyrsTVg.png)  

Cookie: 7cb6efb98ba5972a9b5090dc2e517fe14d12cb04

Then I gave it to the “dcode.fr”

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*TA116ARO4YFK9Ka_5RF-2w.png)  

“Dcode.fr” said It probably SHA-1 hash.

Then I decoded the Hash.  

![](https://miro.medium.com/v2/resize:fit:828/format:webp/1*-AcgBMZM3n5P1jXxX8hh1Q.png)  

The Decrypted value is “false”. So I Encrypted “true” to SHA-1.  

![](https://miro.medium.com/v2/resize:fit:828/format:webp/1*HERU6vA-l7SQoQJjwVn4qg.png)  

Then I set it on the cookie value for the web site.  

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*gfXFuDT6trft-SM4Df_o1w.png)  

The cookie value for “true” in SHA-1 Hash is: `5ffe533b830f08a0326348a9160afafc8ada44db`  

After refreshing the page I got the flag.  

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U7QKiIzBoJSVjCb0R4oCTQ.png)  

I also tried with the burp.  

![](https://miro.medium.com/v2/resize:fit:828/format:webp/1*CuIa95Ftto5COTcOQI9qrg.png)  

It was an interesting CTF.  

---
