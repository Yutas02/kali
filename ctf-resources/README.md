# CTF Resources 🎯

This directory contains helpful scripts and cheatsheets for CTF competitions and penetration testing.

## 📁 Structure

```
ctf-resources/
├── scripts/          # Useful automation scripts
│   ├── reverse_shell.py    # Generate reverse shell payloads
│   ├── quick_scan.sh       # Quick Nmap scan for common CTF ports
│   └── web_fuzzer.py       # Simple web directory fuzzer
└── cheatsheets/      # Quick reference guides
    └── CTF_CHEATSHEET.md   # Comprehensive CTF command reference
```

## 🛠️ Scripts

### reverse_shell.py
Generate reverse shell payloads for various languages and scenarios.

```bash
./scripts/reverse_shell.py <LHOST> <LPORT>
./scripts/reverse_shell.py 10.10.14.5 4444
```

### quick_scan.sh
Quick Nmap scan targeting common CTF service ports.

```bash
./scripts/quick_scan.sh <target>
./scripts/quick_scan.sh 10.10.10.10
```

### web_fuzzer.py
Simple multi-threaded web directory/file fuzzer.

```bash
./scripts/web_fuzzer.py <URL> <WORDLIST> [threads]
./scripts/web_fuzzer.py http://target.com /usr/share/wordlists/dirb/common.txt 20
```

## 📖 Cheatsheets

### CTF_CHEATSHEET.md
Comprehensive reference guide covering:
- Reconnaissance (Nmap, Gobuster, etc.)
- Web application testing (SQLi, XSS, LFI, etc.)
- Password cracking (John, Hashcat, Hydra)
- Reverse shells
- Privilege escalation
- File transfers
- Cryptography
- Forensics
- Binary exploitation

## 💡 Tips

1. **Add these scripts to your PATH** for easy access:
   ```bash
   export PATH=$PATH:/workspaces/kali/ctf-resources/scripts
   ```

2. **Create aliases** for frequently used scripts:
   ```bash
   alias revshell='python3 /workspaces/kali/ctf-resources/scripts/reverse_shell.py'
   alias qscan='bash /workspaces/kali/ctf-resources/scripts/quick_scan.sh'
   ```

3. **Keep the cheatsheet handy**:
   ```bash
   alias cheat='cat /workspaces/kali/ctf-resources/cheatsheets/CTF_CHEATSHEET.md | less'
   ```

## 🤝 Contributing

Have a useful script or want to improve the cheatsheet? Feel free to contribute!

1. Add your script to the `scripts/` directory
2. Make it executable: `chmod +x your_script.sh`
3. Document it in this README
4. Submit a PR!

## ⚠️ Legal Notice

These tools are for authorized security testing, educational purposes, and CTF competitions only. Always ensure you have proper authorization before testing any systems.
