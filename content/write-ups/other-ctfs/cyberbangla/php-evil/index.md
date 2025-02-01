---
title: "PHP Evil | Crypto"
date: 2025-01-18T00:00:53+06:00
draft: false
tags: ["writeups", "cyberbangla", "ctf"]
categories: ["CTF"]
---
## CTF NAME: PHP Evil
**Point:** 250  
**Category:** Web  
**Description:**  
A mysterious developer left behind a piece of code with a sinister reputation, known only as “PHP Evil.” It’s said to be a simple program on the surface, but it hides a twisted secret deep within its logic. Can you navigate the chaos of “PHP Evil” and uncover the hidden flag? Only those who truly understand the language can defeat its darkness. Are you up for the challenge?

http://\<IP>:3334/

**Flag:** CBCTF{you_killed_the_3vil}

**Solve:**  
It can be said that I learned basic PHP to solve this problem.

On the web page, there is just a picture and a source code link.  

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*FVjEPxF3AzQ5gQKdolM8Qg.png)  

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*9Jvwv7tfPIafCGymTBPNdQ.png)  

On the source page, there is this PHP code.

### Let’s analyze the code:

1. **$intermediate_string** is set to ‘**ultimatethunder**’.  

2. **preg_replace** removes occurrences of **$intermediate_string** from **$your_entered_string**.

3. If **$final_string** equals **$intermediate_string**, it calls the function **double_fire_combo()**.
### The logic to exploit is:
**preg_replace** replaces matches of the regular expression pattern (here **$intermediate_string**) in **$your_entered_string** with an empty string.

For **$final_string === $intermediate_string** to hold true, after the replacement, the resultant string must remain exactly ‘**ultimatethunder**’.

Now to bypass it, I have to make sure that my string remains ‘**ultimatethunder**’ after passing the **preg_replace**. Then the function will call the **double_fire_combo()** function.

To test the function I opened a php compiler on W3school. To debug my code.  

![W3School PHP](https://miro.medium.com/v2/resize:fit:828/format:webp/1*-xz25pbJFL2B5AIUvONuxw.png)  

I tried in many ways. After a bunch of tests, I got the perfect result. It took time.

In the variable I input “ultimateultimatethunderthunder”.

In the payload, The middle full word got canceled out and I got the perfect result.

Here, ultimate (ultimatethunder) thunder. After passed the **preg_replace** it remains as **$intermediate_string**.  

![W3school php output](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*w0XxqJeOsexQ_y7y0JA5kA.png)  

I passed your input (this_is_my_power) directly as a value in the query string of the URL

`?this_is_my_power=ultimatethunderultimatethunderthunder`

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*2a5FvX-wF2Hly18sbzUT6A.png)  

And I got the flag.

![](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*qFv_d85CTLrt81VmnTQ_2w.png)  

It was so much fun.

---