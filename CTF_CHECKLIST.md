# CTF Competition Checklist ✅

Use this checklist when participating in a CTF to ensure you're prepared!

## Pre-Competition Setup

### Environment
- [ ] Launch GitHub Codespace or Vagrant VM
- [ ] Verify all tools are installed (`ctf-env`)
- [ ] Test network connectivity
- [ ] Set up note-taking system (markdown files in `/root/ctf/notes/`)

### Tools Check
- [ ] Burp Suite working
- [ ] Metasploit database initialized (`msfdb init`)
- [ ] Wordlists available (`ls /usr/share/wordlists/`)
- [ ] Docker running (`docker ps`)
- [ ] Python tools installed (`pip3 list | grep pwn`)

### Organization
- [ ] Create competition directory (`mkdir -p /root/ctf/challenges/ctf-name`)
- [ ] Set up subdirectories for each category (web, crypto, pwn, etc.)
- [ ] Prepare template scripts

## During Competition

### General Workflow
- [ ] Read the challenge description carefully
- [ ] Download all provided files
- [ ] Document your approach in notes
- [ ] Track solved and attempted challenges

### Web Challenges
- [ ] View page source (Ctrl+U)
- [ ] Check robots.txt
- [ ] Inspect JavaScript files
- [ ] Run directory enumeration
- [ ] Check for common vulnerabilities (SQLi, XSS, LFI, etc.)
- [ ] Intercept requests with Burp Suite
- [ ] Check for hidden form fields
- [ ] Test for IDOR vulnerabilities

### Forensics/Steganography
- [ ] Run `file` command
- [ ] Check file metadata (`exiftool`)
- [ ] Look for embedded files (`binwalk`, `foremost`)
- [ ] Try steghide with empty password
- [ ] Check strings (`strings file | less`)
- [ ] Analyze with hex editor

### Cryptography
- [ ] Identify cipher type
- [ ] Check for classic ciphers (Caesar, Vigenère, etc.)
- [ ] Try common keys/passwords
- [ ] Look for patterns
- [ ] Use CyberChef for decoding chains
- [ ] Consider RSA attacks if applicable

### Binary Exploitation
- [ ] Check file type and architecture
- [ ] Run `checksec`
- [ ] Analyze with Ghidra or Radare2
- [ ] Test for buffer overflow
- [ ] Create pattern for offset finding
- [ ] Check for ROP gadgets
- [ ] Test exploit locally first

### Reverse Engineering
- [ ] Run the binary safely (isolated environment)
- [ ] Check strings
- [ ] Disassemble with Ghidra
- [ ] Look for hardcoded keys/passwords
- [ ] Trace execution with GDB
- [ ] Understand the logic before exploiting

### Network/PCAP Analysis
- [ ] Open in Wireshark
- [ ] Follow TCP streams
- [ ] Export HTTP objects
- [ ] Look for credentials
- [ ] Check for unusual protocols
- [ ] Reconstruct files

## Tips & Best Practices

### Time Management
- [ ] Start with challenges in your strong categories
- [ ] Don't spend more than 30 minutes stuck on one challenge
- [ ] Move on and come back with fresh eyes
- [ ] Keep track of time remaining

### Documentation
- [ ] Take notes on your approach
- [ ] Document failed attempts
- [ ] Save all commands that worked
- [ ] Prepare for potential writeup
- [ ] Screenshot interesting findings

### Team Collaboration (if applicable)
- [ ] Share findings with team
- [ ] Avoid duplicate efforts
- [ ] Communicate what you're working on
- [ ] Help teammates who are stuck
- [ ] Review each other's work

### Flag Submission
- [ ] Check flag format before submitting
- [ ] Copy-paste to avoid typos
- [ ] Watch for trailing whitespace
- [ ] Verify case sensitivity
- [ ] Submit through correct platform

## Post-Challenge

### After Solving
- [ ] Document the solution
- [ ] Save exploit scripts
- [ ] Note interesting techniques
- [ ] Share knowledge with team

### After Competition
- [ ] Write up interesting challenges
- [ ] Review others' writeups
- [ ] Learn from solutions you couldn't get
- [ ] Save useful scripts for future use
- [ ] Update your tools/wordlists

## Quick Commands Reference

### Reconnaissance
```bash
nmap -sV -sC target.com
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt
```

### File Analysis
```bash
file suspicious_file
strings suspicious_file
exiftool image.jpg
binwalk -e file
```

### Crypto
```bash
echo "base64string" | base64 -d
hashid hash.txt
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```

### Exploitation
```bash
# Start listener
nc -lvnp 4444

# Generate payload
revshell 10.10.14.5 4444

# Metasploit
msfconsole
```

## Resources

- [ ] Bookmark CyberChef: https://gchq.github.io/CyberChef/
- [ ] Bookmark RevShells: https://www.revshells.com/
- [ ] Bookmark GTFOBins: https://gtfobins.github.io/
- [ ] Have PayloadsAllTheThings ready
- [ ] Access to HackTricks book
- [ ] Cheatsheet available (`ctf-cheat`)

---

**Good luck and happy hacking! 🎯🚀**
