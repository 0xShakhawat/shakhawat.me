---
title: "Secret | Crypto"
date: 2025-01-18T00:00:58+06:00
draft: false
tags: ["writeups", "cyberbangla", "ctf"]
categories: ["CTF"]
---
## CTF NAME: Secret
**Point:** 70  
**Category:** Crypto  
**Description:**  
The Book of Secrets has secrets on every page.

**Attachment:** Text file. Link gist: https://gist.github.com/0xShakhawat/7ceaea35220d10bcad7d6add1ecd862f
**Flag:** CBCTF{y0u’r3_n0t_r3ady_f0r_my_n3xt_m0ve}

**Solve:**  
After I opened the file on Notepad I saw plaintext. Then, I immediately thought, there would be a Zero-Width Unicode Characters. So, I opened Unicode Steganography with Zero-Width Characters decoder to decode it.

![Zero Width Unicode Character Decoder](https://miro.medium.com/v2/resize:fit:828/format:webp/1*1jyhHZSTM3TIPiDgGXUGyA.png)

**Note:** The hidden Bidirectional Unicode text can be viewed from Code Editors like Sublime Text, VS code, etc. I checked this text in the Sublime Text editor to view hidden characters.

![Hidden Zero Width Unicode Character](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*0x5MnQwEQc7forvuc5Is6w.png)

**Image:** Hidden Zero Width Unicode Characters can be viewed from Sublime text.

**Tool I used:** https://330k.github.io/misc_tools/unicode_steganography.html

---