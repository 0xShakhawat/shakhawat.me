---
title: "Binary Search | Easy"
date: 2025-02-02T00:00:00+06:00
draft: false
tags: ["writeups", "picoCTF", "ctf", "general-skills"]
categories: ["CTF"]
---
## Binary Search
**Difficulty:** Easy  
**Author:** Jeffery John  
**Description:**  
Want to play a game? As you use more of the shell, you might be interested in how they work! Binary search is a classic algorithm used to quickly find an item in a sorted list. Can you find the flag? You'll have 1000 possibilities and only 10 guesses.Cyber security often has a huge amount of data to look through - from logs, vulnerability reports, and forensics. Practicing the fundamentals manually might help you in the future when you have to write your own tools!You can download the challenge files here:

- [challenge.zip](https://artifacts.picoctf.net/c_atlas/19/challenge.zip)

ssh -p 50900 ctf-player@atlas.picoctf.net
Using the password ********. Accept the fingerprint with yes, and ls once connected to begin. Remember, in a shell, passwords are hidden!  

**Flag:** picoCTF{g00d_gu355_1597707f}

## Solve:  
### Overview 
In this challenge, I was given a binary search game where I had to guess a randomly generated number between 1 and 1000 within 10 attempts. The challenge aimed to reinforce binary search principles, a crucial algorithm used to efficiently locate an element in a sorted dataset.

### Understanding the Game
The script follows a standard binary search approach, providing feedback on whether our guess was too high or too low. We needed to apply an optimal guessing strategy to find the correct number in minimal attempts.  

### Strategy: Binary Search
Since the game provided hints (higher/lower), I followed a binary search approach:

- Start at the middle of the range: 500
- If the guess is too high, move to the lower half; if too low, move to the upper half.
- Repeat the process until the correct number is found.
By following this method, I quickly reached the correct answer:  
  
  
```shell
┌──(psychic㉿0xShakhawat)-[~/…/Binary Search/home/ctf-player/drop-in]
└─$ ssh -p 50900 ctf-player@atlas.picoctf.net

Welcome to the Binary Search Game!
I'm thinking of a number between 1 and 1000.
Enter your guess: 500
Higher! Try again.
Enter your guess: 750
Lower! Try again.
Enter your guess: 625
Lower! Try again.
Enter your guess: 563
Lower! Try again.
Enter your guess: 532
Higher! Try again.
Enter your guess: 548
Lower! Try again.
Enter your guess: 540
Lower! Try again.
Enter your guess: 536
Higher! Try again.
Enter your guess: 538
Congratulations! You guessed the correct number: 538
Here's your flag: picoCTF{g00d_gu355_1597707f}
Connection to atlas.picoctf.net closed.  
                                              
```

### Challenge Script 

```python

            #!/bin/bash

            # Generate a random number between 1 and 1000
            target=$(( (RANDOM % 1000) + 1 ))

            echo "Welcome to the Binary Search Game!"
            echo "I'm thinking of a number between 1 and 1000."

            # Trap signals to prevent exiting
            trap 'echo "Exiting is not allowed."' INT
            trap '' SIGQUIT
            trap '' SIGTSTP

            # Limit the player to 10 guesses
            MAX_GUESSES=10
            guess_count=0

            while (( guess_count < MAX_GUESSES )); do
                read -p "Enter your guess: " guess

                if ! [[ "$guess" =~ ^[0-9]+$ ]]; then
                    echo "Please enter a valid number."
                    continue
                fi

                (( guess_count++ ))

                if (( guess < target )); then
                    echo "Higher! Try again."
                elif (( guess > target )); then
                    echo "Lower! Try again."
                else
                    echo "Congratulations! You guessed the correct number: $target"

                    # Retrieve the flag from the metadata file
                    flag=$(cat /challenge/metadata.json | jq -r '.flag')
                    echo "Here's your flag: $flag"
                    exit 0  # Exit with success code
                fi
            done

            # Player has exceeded maximum guesses
            echo "Sorry, you've exceeded the maximum number of guesses."
            exit 1  # Exit with error code to close the connection

```