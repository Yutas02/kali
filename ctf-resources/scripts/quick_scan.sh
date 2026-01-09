#!/bin/bash
# CTF Port Scanner - Quick scan for common CTF service ports

TARGET=$1
if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target>"
    echo "Example: $0 10.10.10.10"
    exit 1
fi

echo "🔍 Scanning common CTF ports on $TARGET..."
echo ""

# Quick scan of common CTF ports
nmap -sV -sC -p 21,22,80,443,445,3306,8080,8000,9000 -oN /tmp/quick_scan.txt $TARGET

echo ""
echo "📄 Results saved to /tmp/quick_scan.txt"
echo ""
echo "💡 For full port scan, run:"
echo "   nmap -p- -sV -sC $TARGET"
