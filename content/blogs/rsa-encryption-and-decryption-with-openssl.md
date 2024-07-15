---
title: "Demystifying RSA Encryption and Decryption with OpenSSL"
date: 2023-12-06T16:08:00+06:00
draft: false
tags: ["cryptography", "rsa-algorithm", "infosec"]
categories: ["Cryptography"] 
---

In the realm of secure communication, RSA encryption plays a pivotal role, offering a robust solution through its public-key cryptography. This blog post aims to demystify the intricacies of RSA encryption and decryption, using the versatile OpenSSL tool.

## Overview of RSA
RSA, named after its inventors Rivest, Shamir, and Adleman, relies on the mathematical properties of large prime numbers. It involves the generation of a public key for encryption and a corresponding private key for decryption. This asymmetry forms the basis for secure data transmission and digital signatures.

## Setting Up OpenSSL
Before delving into RSA operations, ensure you have OpenSSL installed. The installation process varies across operating systems, but OpenSSL’s command-line interface remains consistent.

```
# Install OpenSSL on Linux (Debian/Ubuntu)
sudo apt-get install openssl

# Install OpenSSL on macOS (using Homebrew)
brew install openssl

# Install OpenSSL on Windows
Download and install the binaries from https://slproweb.com/products/Win32OpenSSL.html
```

## Generating RSA Key Pair
Let’s kick things off by generating an RSA key pair. The following commands create a private key (private.pem)

![RSA generate command openSSL](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*5_c3J95Y-sktXVVDNnMfTA.jpeg)

`openssl genrsa --out private.pem 1024`

I used 1048bit, you can use 2048bit or 3072bit for larger message encryption. I used (.pem) as an extension but you can use anything like (.txt), Etc. But (.pem) is better. PEM stands for Privacy Enhanced Mail.

Here is our private key:

![RSA Private Key](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*Q--VNfk8VMuA1jJty10_6A.jpeg)

Let’s create a public key from this private key.

![Generating Public Key from Private key](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*kmKZujXcberjIbBiTn0Llw.jpeg)

`openssl rsa --in private.pem --out public.pem --outform PEM --pubout`

I am using this command. Here is the result.

![RSA Public key file](https://miro.medium.com/v2/resize:fit:1400/1*sCy7JPXJjW-YW3Yjx30Jag.jpeg)

![RSA Public Key](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*nzpnqUUGsIOE3cyEtyw4_Q.jpeg)

Creating a Message file
I used echo to create a txt file message. The file name is “msg.txt”

`echo "Hi friend. How are you?" >> msg.txt`

![Message File](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*fXyLXurZQUR-EXD5Lrx9iQ.jpeg)

The message is: “Hi friend. How are you?”

## Encrypting Data with RSA
Now that we have our keys, let’s encrypt some data using the public key. This ensures that only the possessor of the private key can decrypt and access the original information.

![RSA Encrypt command](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*myjfROIJFwssi5fYtHiwkA.jpeg)

![RSA Encrypted message](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*B_bS7BhYZo02raeYMGXseQ.jpeg)

`openssl pkeyutl --encrypt --inkey public.pem --pubin --in msg.txt --out enmsg.enc`

now I have an encrypted data file named enmsg.enc

And I can safely delete my unencrypted message.

![Delete source message](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*QjJRfRFzhH9ryqWtKh1Meg.jpeg)

I use the rm command to remove the unencrypted message file.

now I have only an encrypted message file.

## Decrypting Data with RSA
To decrypt the data, we utilize the private key. This step ensures that only the rightful owner of the private key can reveal the original content.

![RSA Decrypt command](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*VHZrjDVp39426Rwfh5M0eg.jpeg)

![RSA Decrypted message](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*8fOIgHgGZXI2encRNF5FAA.jpeg)

`openssl pkeyutl --decrypt --inkey private.pem --in enmsg.enc --out message.txt`

I used this command to decrypt the message. Now, I can view the message in plaintext.

## Best Practices and Security Considerations
As we venture into the cryptographic landscape, it’s essential to adopt best practices. Securely storing private keys and considering key length are crucial aspects. Regularly check for updates and be mindful of potential vulnerabilities associated with OpenSSL.

## Conclusion
In conclusion, RSA encryption and decryption, coupled with OpenSSL, provide a robust foundation for securing digital communication. By understanding the principles and practices outlined in this post, you’re equipped to navigate the intricacies of RSA cryptography.

## Additional Resources
For further exploration, refer to the official OpenSSL documentation, and consider practical exercises to deepen your understanding.

That's it.

I also published blog this on my [Medium](https://0xshakhawat.medium.com/demystifying-rsa-encryption-and-decryption-with-openssl-ea1e86e30271) Blog

You guys can subscribe to my YouTube channel 0xShakhawat
My portfolio site: https://shakhawat.me