---
title: "Pain | OSINT"
date: 2025-01-18T00:00:50+06:00
draft: false
tags: ["writeups", "cyberbangla", "ctf"]
categories: ["CTF"]
---
## CTF NAME: Pain
**Point:** 200  
**Category:** OSINT  
**Description:**  
My friend naurto got under attack by pain. To defeat pain he have to know all the history about pain. Can you help Naruto to defeat pain???

https://darkefsad.github.io/

**Flag:** CBCTF{pa1n_is_sucexx}

**Solve:**  
The website contains a picture of “Pain” who is a villain of Naruto and about himself.

I’ve read the description of the challenge and there is a word called “history”. I remembered that word.

After seeing the URL, the site looks like it is deployed on “GitHub pages”.

![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*16pbQD5yQl2SejfAWqkyVg.png)  

And then I remembered the word “history”. Now, my work it to check the commit history of the site, if the repository is public.

Then I crafted the URL to view the user profile: https://github.com/darkefsad

There is only one repository.  

![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*Tqso7vcQQvY0MtlLba8tOA.png)  

![](https://miro.medium.com/v2/resize:fit:828/format:webp/1*e130IHPzMhATzHzrkXjd5w.png)  

Then I’ve checked the “create flag” commit. And I got the flag.

---