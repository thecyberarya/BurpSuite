#!/bin/bash

echo "
                

  _______ _             _____      _                                           
 |__   __| |           / ____|    | |                   /\                     
    | |  | |__   ___  | |    _   _| |__   ___ _ __     /  \   _ __ _   _  __ _ 
    | |  | '_ \ / _ \ | |   | | | | '_ \ / _ \ '__|   / /\ \ | '__| | | |/ _` |
    | |  | | | |  __/ | |___| |_| | |_) |  __/ |     / ____ \| |  | |_| | (_| |
    |_|  |_| |_|\___|  \_____\__, |_.__/ \___|_|    /_/    \_\_|   \__, |\__,_|
                              __/ |                                 __/ |      
                             |___/                                 |___/       
 
               ========== Github: github.com/itsdhirajarya ==========
"
echo "
==================================================================================

Download File Size:
1. Java 18 : 195MB
2. Java 8 : 95MB
3. Burp Suite Professional : 520MB

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

