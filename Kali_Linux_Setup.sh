#!/bin/bash

echo "
 
████████╗██╗  ██╗███████╗     ██████╗██╗   ██╗██████╗ ███████╗██████╗      █████╗ ██████╗ ██╗   ██╗ █████╗ 
╚══██╔══╝██║  ██║██╔════╝    ██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗    ██╔══██╗██╔══██╗╚██╗ ██╔╝██╔══██╗
   ██║   ███████║█████╗      ██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝    ███████║██████╔╝ ╚████╔╝ ███████║
   ██║   ██╔══██║██╔══╝      ██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗    ██╔══██║██╔══██╗  ╚██╔╝  ██╔══██║
   ██║   ██║  ██║███████╗    ╚██████╗   ██║   ██████╔╝███████╗██║  ██║    ██║  ██║██║  ██║   ██║   ██║  ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝                                                                                                          
   
               ========== Github: github.com/itsdhirajarya ==========
"
echo "
==================================================================================

Download File Size:
1. Burp Suite Professional : 520MB

==================================================================================

"

if [[ $EUID -eq 0 ]]; then
    # Download Burp Suite Profesional Latet Version
    echo 'Downloading Burp Suite Professional ....'
    Link="https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar"
    wget "$Link" -O Burp-Suite-Pro.jar --quiet --show-progress
    sleep 2

    # execute Keygenerator
    echo 'Starting Keygenerator'
    (java -jar keygen.jar) &
    sleep 3s
    
    # Execute Burp Suite Professional with Keyloader
    echo 'Executing Burp Suite Professional with Keyloader'
    echo "java --illegal-access=permit -Dfile.encoding=utf-8 -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/Burp-Suite-Pro.jar &" > burp
    chmod +x burp
    cp burp /bin/burp 
    (./burp)
else
    echo "Execute Command as Root User"
    exit
fi

