# Quick Start Guide for GitHub Codespaces 🚀

## Getting Started in 3 Steps

### 1. Launch Your Codespace

Click the green "Code" button on the repository page, then:
- Select the "Codespaces" tab
- Click "Create codespace on main"

**OR** use the direct link: [Launch Codespace](https://codespaces.new/brignano/kali)

### 2. Wait for Setup (3-5 minutes)

The first launch will:
- Pull the Kali Linux Docker image
- Install all CTF tools (nmap, burpsuite, metasploit, etc.)
- Configure your environment
- Set up custom aliases

You'll see a welcome message when everything is ready!

### 3. Start Hacking!

Your Codespace is now a full Kali Linux environment in the cloud.

## First Commands to Try

```bash
# Verify your environment
ctf-env

# Check available tools
which nmap gobuster sqlmap metasploit-framework john hashcat

# Start a practice target
juice-shop
# Access at http://localhost:3000

# View the comprehensive cheatsheet
ctf-cheat

# Generate reverse shell payloads
revshell 10.10.14.5 4444

# Quick port scan
qscan target.com
```

## Understanding Your Workspace

### Directory Structure
```
/root/
├── ctf/
│   ├── challenges/    # Store CTF challenge files here
│   ├── tools/        # Custom tools and exploits
│   ├── scripts/      # Your solution scripts
│   ├── wordlists/    # Custom wordlists
│   └── notes/        # CTF notes and writeups
└── shared/           # Synced with repo's shared/ directory
```

### Persistent Storage
- Files in `/root/shared/` are synced with the repository
- Use this for scripts and tools you want to keep
- Other files may be lost when the Codespace is deleted

## CTF Workflow Example

### Web Challenge
```bash
# 1. Scan the target
nmap -sV -sC target.com

# 2. Enumerate directories
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt

# 3. Test for SQL injection
sqlmap -u "http://target.com/page?id=1" --dbs

# 4. Analyze with BurpSuite
burpsuite &
```

### Binary Exploitation
```bash
# 1. Analyze the binary
file challenge
checksec challenge

# 2. Debug with GDB
gdb ./challenge

# 3. Find buffer overflow offset
/usr/share/metasploit-framework/tools/exploit/pattern_create.rb -l 500

# 4. Exploit with pwntools
python3 exploit.py
```

### Password Cracking
```bash
# 1. Identify hash type
hashid hash.txt

# 2. Crack with John
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt

# 3. Or use Hashcat
hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/rockyou.txt
```

## Port Forwarding

Codespaces automatically forwards common CTF ports:
- **3000** - Web apps / Juice Shop
- **4444** - Reverse shells
- **8000** - HTTP server
- **8080** - Proxy / Alternative HTTP
- **9000** - Additional services

To forward additional ports:
1. Open the "Ports" tab in VS Code
2. Click "Forward a Port"
3. Enter the port number

## Using Docker

Docker is pre-installed for running vulnerable applications:

```bash
# List available images
docker images

# Run OWASP Juice Shop
juice-shop

# Run other vulnerable apps
docker run -d -p 80:80 vulnerables/web-dvwa
```

## CTF Practice Platforms

Use your Codespace with these platforms:

- **[HackTheBox](https://www.hackthebox.com/)** - Download VPN config, connect from Codespace
- **[TryHackMe](https://tryhackme.com/)** - Similar to HTB
- **[PicoCTF](https://picoctf.org/)** - Beginner-friendly challenges
- **[CTFTime](https://ctftime.org/)** - Find live CTF competitions

## Tips & Tricks

### 1. Keep Your Codespace Running
- Codespaces auto-stop after 30 minutes of inactivity (configurable)
- Your work is saved, but running processes will stop

### 2. Install Additional Tools
```bash
apt update
apt install <tool-name>
```

### 3. Save Your Work
- Commit changes: `git add . && git commit -m "message"`
- Or use VS Code's Source Control panel

### 4. Multiple Terminal Windows
- Use `tmux` or VS Code's split terminal feature
- Great for running a listener while working on exploits

### 5. Transfer Files
```bash
# From local to Codespace: Upload via VS Code
# From Codespace to local: Download via VS Code

# Or use GitHub gists for quick sharing
gh gist create file.txt
```

## Troubleshooting

### Tool Not Found?
```bash
# Update package list and install
apt update
apt install <tool-name>
```

### Out of Memory?
- Close unused applications
- Restart the Codespace
- Consider upgrading to a larger machine type

### Network Issues?
```bash
# Check connectivity
ping 8.8.8.8
curl https://google.com

# Check DNS
nslookup google.com
```

### Need More Storage?
- Clean up Docker images: `docker system prune -a`
- Remove unnecessary files
- Archive old challenges

## Advanced Features

### VS Code Extensions
Pre-installed extensions:
- Python support
- Hex editor
- GitHub Copilot (if you have access)

### Custom Tool Installation
Create a script in `/root/ctf/tools/` for easy reinstallation:

```bash
#!/bin/bash
# install-custom-tools.sh
pip3 install <python-package>
go install <go-package>
```

### Environment Variables
Add to `~/.zshrc`:
```bash
export MYVAR="value"
```

## Getting Help

- **Cheatsheet**: Run `ctf-cheat` for quick command reference
- **Tool Help**: Most tools have `--help` or `-h` flags
- **Man Pages**: `man <command>`
- **Google/StackOverflow**: Specific error messages

## Resources

- [Kali Linux Docs](https://www.kali.org/docs/)
- [HackTricks Book](https://book.hacktricks.xyz/)
- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)
- [GTFOBins](https://gtfobins.github.io/)
- [RevShells Generator](https://www.revshells.com/)

---

**Happy Hacking! 🎯**

Need more help? Check the [main README](../readme.md) or open an issue on GitHub.
