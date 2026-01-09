# Kali Linux CTF Environment 🎯

> Easily set up a complete Kali Linux penetration testing environment for CTFs and security research using GitHub Codespaces or Vagrant.

## 🚀 Quick Start with GitHub Codespaces (Recommended)

The easiest way to get started! Click the button below to launch a fully configured Kali Linux environment in your browser:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/brignano/kali)

### Why Codespaces?
- ✅ **Zero Setup**: No local installation required
- ✅ **Browser-Based**: Works on any device with a web browser
- ✅ **Pre-configured**: All CTF tools installed and ready to use
- ✅ **Fast**: Powerful cloud VMs for resource-intensive tasks
- ✅ **Perfect for CTFs**: Access from anywhere, collaborate easily

### First Time Using This Codespace?

Once your Codespace launches (takes ~3-5 minutes for initial setup):

1. Open the integrated terminal (it should open automatically)
2. You'll see a welcome message with available tools
3. Run `ctf-env` to verify your environment is ready
4. Start hacking! 🔥

## 🛠️ Available Tools

This environment comes pre-loaded with essential CTF and penetration testing tools:

### Web Application Testing
- BurpSuite Community Edition
- OWASP ZAP
- SQLMap
- Nikto
- Gobuster, Dirb, FFuF, WFuzz

### Network & Reconnaissance
- Nmap
- Netcat
- Wireshark, TCPDump
- DNSUtils, Whois
- Subfinder, HTTPx

### Password & Hash Cracking
- John the Ripper
- Hashcat
- Hydra

### Reverse Engineering & Binary Exploitation
- Ghidra
- Radare2
- GDB with pwndbg
- Python pwntools
- ROPgadget, Ropper

### Forensics & Steganography
- Volatility 3
- Binwalk
- Foremost
- Steghide
- ExifTool

### Exploitation
- Metasploit Framework
- SearchSploit (Exploit-DB)

### Cryptography & Encoding
- Python z3-solver
- OpenSSL
- Base64, URL encoding/decoding tools

### Programming & Scripting
- Python 3 with pip (pwntools, pycryptodome, requests, scapy, angr)
- Go (latest)
- Java (OpenJDK 17)

### Docker-Based Vulnerable Apps
- OWASP Juice Shop (pre-loaded)

## 📖 Common CTF Tasks

### Start a Web Challenge Environment
```bash
# Start OWASP Juice Shop
juice-shop

# Access at http://localhost:3000 (port will auto-forward)
```

### Host Files for Download
```bash
# Start HTTP server on port 8000
python3 -m http.server 8000

# Or use alias
serve
```

### Network Scanning
```bash
# Basic Nmap scan
nmap -sV -sC target.com

# Directory fuzzing
gobuster dir -u http://target.com -w /usr/share/wordlists/dirb/common.txt
```

### Password Cracking
```bash
# John the Ripper
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt

# Hashcat
hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/rockyou.txt
```

### Binary Analysis
```bash
# Open in Ghidra
ghidra

# Use Radare2
r2 binary_file

# Debug with GDB
gdb binary_file
```

### Search for Exploits
```bash
searchsploit apache 2.4
```

### Metasploit
```bash
msfconsole
```

## 📁 Workspace Structure

```
/root/
├── ctf/
│   ├── challenges/    # Store CTF challenges here
│   ├── tools/        # Custom tools and scripts
│   ├── scripts/      # Your solution scripts
│   ├── wordlists/    # Custom wordlists
│   └── notes/        # CTF notes and writeups
└── shared/           # Persistent files (synced with repo)
```

## 🎓 CTF Tips

### Useful Aliases
- `ll` - Detailed file listing
- `ports` - Show listening ports
- `serve` - Start HTTP server
- `myip` - Get your public IP
- `decode64` / `encode64` - Base64 encoding/decoding
- `urldecode` / `urlencode` - URL encoding/decoding
- `juice-shop` - Start OWASP Juice Shop

### Common Wordlists
SecLists wordlists are available in `/usr/share/wordlists/seclists/`

### Port Forwarding
Common CTF ports (3000, 4444, 8000, 8080, 9000) are auto-forwarded. You can forward additional ports in the "Ports" tab in VS Code.

## 💻 Alternative: Local Setup with Vagrant

If you prefer running Kali Linux locally with VirtualBox:

### Prerequisites
- [Vagrant](https://www.vagrantup.com/)
- [VirtualBox](https://www.virtualbox.org/)

### Usage
```sh
# Start and provision the VM
vagrant up

# SSH into the VM
vagrant ssh

# Stop the VM
vagrant halt

# Destroy the VM
vagrant destroy
```

The Vagrant setup will:
- Download Kali Linux Rolling
- Configure 4GB RAM and 2 CPUs
- Install additional tools (Docker, VSCode, Tor)
- Set up custom shell aliases
- Mount `./shared` directory to `/home/vagrant/shared`

## 🤝 Contributing

Found a tool that should be included? Want to add helpful scripts or documentation? Contributions are welcome!

1. Fork this repository
2. Create a feature branch
3. Add your improvements
4. Submit a pull request

## 📝 Notes

- **GitHub Codespaces**: Free tier includes 60 hours/month. Perfect for CTFs!
- **Resource Usage**: Some tools (like Hashcat) work best with GPU acceleration, which may not be available in Codespaces
- **Persistent Storage**: Files in `/root/shared/` persist across Codespace rebuilds
- **Tool Updates**: Run `apt update && apt upgrade` to get latest versions

## ⚠️ Legal Disclaimer

This environment is for educational purposes, authorized security testing, and CTF competitions only. Always ensure you have permission before testing any systems you don't own.

## 🔗 Useful Resources

- [Kali Linux Documentation](https://www.kali.org/docs/)
- [CTFTime](https://ctftime.org/) - Find CTF competitions
- [HackTheBox](https://www.hackthebox.com/) - Practice platform
- [TryHackMe](https://tryhackme.com/) - Guided learning
- [PicoCTF](https://picoctf.org/) - Beginner-friendly CTFs

---

**Happy Hacking! 🚀** If you find this useful, give it a ⭐!
