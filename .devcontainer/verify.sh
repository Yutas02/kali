#!/bin/bash
# Verification script for Kali CTF Environment
echo "🔍 Verifying Kali CTF Environment..."
echo ""

errors=0
checks=("✅" "❌")

# Check Python
if command -v python3 &> /dev/null; then
    echo "${checks[0]} Python 3 installed: $(python3 --version)"
else
    echo "${checks[1]} Python 3 NOT found"
    ((errors++))
fi

# Check Git
if command -v git &> /dev/null; then
    echo "${checks[0]} Git installed: $(git --version)"
else
    echo "${checks[1]} Git NOT found"
    ((errors++))
fi

# Check Zsh
if [ -f /root/.zshrc ]; then
    echo "${checks[0]} Zsh configured"
else
    echo "${checks[1]} Zsh NOT configured"
    ((errors++))
fi

# Check CTF aliases
if grep -q "ctf_aliases" /root/.zshrc 2>/dev/null; then
    echo "${checks[0]} CTF aliases configured"
else
    echo "${checks[1]} CTF aliases NOT configured"
    ((errors++))
fi

# Check CTF workspace
if [ -d /root/ctf ]; then
    echo "${checks[0]} CTF workspace created"
else
    echo "${checks[1]} CTF workspace NOT created"
    ((errors++))
fi

# Check Python packages
if python3 -c "import requests" 2>/dev/null; then
    echo "${checks[0]} Python 'requests' available"
else
    echo "${checks[1]} Python 'requests' NOT available"
    ((errors++))
fi

echo ""
if [ $errors -eq 0 ]; then
    echo "✅ All checks passed! Environment is ready."
    exit 0
else
    echo "⚠️  $errors check(s) failed. Some features may not work."
    exit 1
fi
