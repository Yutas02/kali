#!/usr/bin/env python3
"""
Web Fuzzer - Quick directory and file fuzzing script
"""

import requests
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed

def check_path(url, path):
    try:
        full_url = f"{url.rstrip('/')}/{path.strip()}"
        response = requests.get(full_url, timeout=5, allow_redirects=False)
        if response.status_code in [200, 301, 302, 403]:
            return (full_url, response.status_code, len(response.content))
    except (requests.RequestException, Exception):
        pass
    return None

def fuzz(url, wordlist_path, threads=10):
    print(f"🔍 Fuzzing {url} with {wordlist_path}")
    print("="*60)
    
    with open(wordlist_path, 'r') as f:
        paths = [line.strip() for line in f if line.strip() and not line.startswith('#')]
    
    results = []
    with ThreadPoolExecutor(max_workers=threads) as executor:
        futures = {executor.submit(check_path, url, path): path for path in paths}
        for future in as_completed(futures):
            result = future.result()
            if result:
                results.append(result)
                print(f"[{result[1]}] {result[0]} ({result[2]} bytes)")
    
    print("="*60)
    print(f"✅ Found {len(results)} results")

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: web_fuzzer.py <URL> <WORDLIST> [threads]")
        print("Example: web_fuzzer.py http://target.com /usr/share/wordlists/dirb/common.txt 20")
        sys.exit(1)
    
    url = sys.argv[1]
    wordlist = sys.argv[2]
    threads = int(sys.argv[3]) if len(sys.argv) > 3 else 10
    
    fuzz(url, wordlist, threads)
