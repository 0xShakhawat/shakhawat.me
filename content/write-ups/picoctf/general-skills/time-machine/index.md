---
title: "Time Machine | Easy"
date: 2025-02-02T00:00:01+06:00
draft: false
tags: ["writeups", "picoCTF", "ctf", "general-skills"]
categories: ["CTF"]
---
## Binary Search
**Difficulty:** Easy  
**Author:** Jeffery John  
**Description:**  
What was I last working on? I remember writing a note to help me remember...
You can download the challenge files here:
- [challenge.zip](https://artifacts.picoctf.net/c_titan/161/challenge.zip)   

**Flag:** picoCTF{t1m3m@ch1n3_8defe16a}  

## Solve:  
Downloaded file contains a .git folder and a message.txt file.
```shell
┌──(psychic㉿0xShakhawat)-[~/ctf/picoctf/Time Machine/drop-in]
└─$ ls -a 
.  ..  .git  message.txt
```

I checked the **message.txt**
```shell
┌──(psychic㉿0xShakhawat)-[~/ctf/picoctf/Time Machine/drop-in]
└─$ cat message.txt 
This is what I was working on, but I'd need to look at my commit history to know why...                                                                                                                    
```
Here, the message talking about "commit history".  

So, I checked for the .git folder. And I found the flag on `.git/logs/refs/heads/master` file

Here is output of the file:
```shell
┌──(psychic㉿0xShakhawat)-[~/…/.git/logs/refs/heads]
└─$ cat master        
0000000000000000000000000000000000000000 10228f3d6437701ef5aaac04213757031f30ebec picoCTF <ops@picoctf.com> 1710202044 +0000        commit (initial): 
picoCTF{t1m3m@ch1n3_8defe16a}
                                                
```

