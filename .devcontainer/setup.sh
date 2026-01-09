#!/bin/bash
set -e

echo "🔧 Setting up Kali Linux CTF Environment..."

# Update package lists
echo "📦 Updating package lists..."
apt-get update -qq

# Install essential Kali tools for CTF
echo "🛠️  Installing CTF and pentesting tools..."
apt-get install -y -qq \
    kali-tools-top10 \
    kali-tools-web \
    kali-tools-passwords \
    kali-tools-reverse-engineering \
    kali-tools-forensics \
    kali-tools-crypto-stego \
    nmap \
    netcat-traditional \
    wireshark \
    tcpdump \
    aircrack-ng \
    john \
    hashcat \
    hydra \
    sqlmap \
    nikto \
    dirb \
    gobuster \
    wfuzz \
    ffuf \
    burpsuite \
    zaproxy \
    metasploit-framework \
    exploitdb \
    searchsploit \
    binwalk \
    steghide \
    exiftool \
    foremost \
    volatility3 \
    radare2 \
    gdb \
    pwndbg \
    ghidra \
    ltrace \
    strace \
    curl \
    wget \
    git \
    vim \
    nano \
    tmux \
    screen \
    python3-pip \
    python3-venv \
    pipx \
    golang \
    openjdk-17-jdk \
    build-essential \
    net-tools \
    dnsutils \
    whois \
    tor \
    proxychains4 \
    socat \
    rlwrap \
    jq \
    yq \
    bat \
    ripgrep \
    fd-find \
    fzf \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting

# Install Docker-based tools
echo "🐳 Setting up Docker-based tools..."
docker pull bkimminich/juice-shop 2>/dev/null || true

# Install useful Python tools for CTF
echo "🐍 Installing Python CTF libraries..."
pip3 install --break-system-packages --quiet \
    pwntools \
    pycryptodome \
    requests \
    beautifulsoup4 \
    scapy \
    z3-solver \
    angr \
    ropper \
    ropgadget \
    capstone \
    keystone-engine \
    unicorn

# Install useful Go tools
echo "🔷 Installing Go security tools..."
export GOPATH=/root/go
export PATH=$PATH:$GOPATH/bin
go install github.com/ffuf/ffuf/v2@latest 2>/dev/null || true
go install github.com/OJ/gobuster/v3@latest 2>/dev/null || true
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest 2>/dev/null || true
go install github.com/projectdiscovery/httpx/cmd/httpx@latest 2>/dev/null || true
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>/dev/null || true

# Setup custom shell configuration
echo "⚙️  Configuring shell..."
if [ -f "/workspaces/kali/.zsh_aliases" ]; then
    cp /workspaces/kali/.zsh_aliases /root/.zsh_aliases
fi

# Add aliases to .zshrc
cat >> /root/.zshrc << 'EOF'

# Load custom aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# CTF-specific aliases
alias ll='ls -lah'
alias ports='netstat -tulanp'
alias serve='python3 -m http.server'
alias myip='curl -s ifconfig.me'
alias decode64='base64 -d'
alias encode64='base64'
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

# Quick CTF environment setup
alias ctf-env='echo "🚩 CTF Environment Ready! Tools: nmap, burpsuite, metasploit, john, hashcat, gobuster, sqlmap, etc."'

# Go tools in PATH
export GOPATH=/root/go
export PATH=$PATH:$GOPATH/bin

EOF

# Create useful directories
echo "📁 Creating workspace directories..."
mkdir -p /root/ctf/{challenges,tools,scripts,wordlists,notes}
mkdir -p /root/shared

# Download common wordlists
echo "📚 Setting up wordlists..."
if [ ! -d "/usr/share/wordlists/seclists" ]; then
    git clone --quiet --depth 1 https://github.com/danielmiessler/SecLists.git /usr/share/wordlists/seclists 2>/dev/null || true
fi

# Setup searchsploit
echo "🔍 Updating exploit database..."
searchsploit -u || true

# Clean up
echo "🧹 Cleaning up..."
apt-get clean
rm -rf /var/lib/apt/lists/*

# Print welcome message
cat > /root/WELCOME.txt << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║   🎯 Kali Linux CTF Environment - Ready for Action! 🎯          ║
║                                                                  ║
║  This Codespace includes:                                        ║
║   • Kali Linux penetration testing tools                        ║
║   • Web application testing (BurpSuite, ZAP, SQLMap)            ║
║   • Network scanning (Nmap, Gobuster, Nikto)                    ║
║   • Password cracking (John, Hashcat, Hydra)                    ║
║   • Reverse engineering (Ghidra, Radare2, GDB)                  ║
║   • Forensics (Volatility, Binwalk, Foremost)                   ║
║   • Crypto/Stego tools (Steghide, ExifTool)                     ║
║   • Metasploit Framework                                         ║
║   • Python CTF libraries (pwntools, angr, z3)                   ║
║                                                                  ║
║  Quick Start:                                                    ║
║   • Run 'ctf-env' to see available tools                        ║
║   • Start Juice Shop: juice-shop                                ║
║   • HTTP Server: serve 8000                                     ║
║   • Metasploit: msfconsole                                      ║
║   • Search exploits: searchsploit <term>                        ║
║                                                                  ║
║  Directories:                                                    ║
║   • /root/ctf/ - Your CTF workspace                             ║
║   • /root/shared/ - Persistent shared files                     ║
║   • /usr/share/wordlists/ - Common wordlists                    ║
║                                                                  ║
║  Happy Hacking! 🚀                                               ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
EOF

cat /root/WELCOME.txt

# Add welcome message to .zshrc
echo "cat /root/WELCOME.txt" >> /root/.zshrc

echo "✅ Kali Linux CTF Environment setup complete!"
