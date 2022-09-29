# Name is Important
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

# Set Wget Progress to Silent, Becuase it slows down Downloading by +50x
echo "Setting Wget Progress to Silent, Becuase it slows down Downloading by +50x`n"
$ProgressPreference = 'SilentlyContinue'

# Check JDK-18 Availability or Download JDK-18
$jdk18 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java(TM) SE Development Kit 18*"
if (!($jdk18)){
    echo "`t`tDownnloading Java JDK-18 ....(size-195MB)"
    #wget "https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe" -O jdk-18.exe    
    echo "`n`t`tJDK-18 Downloaded, lets start the Installation process"
    start -wait jdk-18.exe
    rm jdk-18.exe
}else{
    echo "Required Already JDK-18 is Installed"
    $jdk18
}

# Check JRE-8 Availability or Download JRE-8
$jre8 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java 8 Update *"
if (!($jre8)){
    echo "`n`t`tDownloading Java JRE ....(size-95MB)"
    #wget "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246474_2dee051a5d0647d5be72a7c0abff270e" -O jre-8.exe
    echo "`n`t`tJRE-8 Downloaded, lets start the Installation process"
    start -wait jre-8.exe
    rm jre-8.exe
}else{
    echo "`n`nRequired JRE-8 is Installed`n"
    $jre8
}

# Downloading Burp Suite Professional
if (Test-Path Burp-Suite-Pro.jar){
    echo "Burp Suite Professional JAR file is available.`nChecking its Integrity ...."
    if (((Get-Item Burp-Suite-Pro.jar).length/1MB) -lt 500 ){
        echo "`n`t`tFiles Seems to be corrupted `n`t`tDownloading Latest Burp Suite Professional ...."
        #wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O "Burp-Suite-Pro.jar"
        echo "`nBurp Suite Professional is Downloaded.`n"
    }else {echo "File Looks fine. Lets proceed for Execution"}
}else {
    echo "`n`t`tDownloading Latest Burp Suite Professional ....(size-520MB)"
    #wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O Burp-Suite-Pro.jar
    echo "`nBurp Suite Professional is Downloaded.`n"
}

# Creating Burp.bat file with command for execution
if (Test-Path burp.bat) {rm burp.bat} 
$path = "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:`"$pwd\loader.jar`" -noverify -jar `"$pwd\Burp-Suite-Pro.jar`""
$path | add-content -path Burp.bat
echo "`nBurp.bat file is created"


# Creating Burp-Suite-Pro.vbs File for background execution
if (Test-Path Burp-Suite-Pro.vbs) {
   Remove-Item Burp-Suite-Pro.vbs}
echo "Set WshShell = CreateObject(`"WScript.Shell`")" > Burp-Suite-Pro.vbs
add-content Burp-Suite-Pro.vbs "WshShell.Run chr(34) & `"$pwd\Burp.bat`" & Chr(34), 0"
add-content Burp-Suite-Pro.vbs "Set WshShell = Nothing"
echo "`nBurp-Suite-Pro.vbs file is created."


# Lets Activate Burp Suite Professional with keygenerator and Keyloader
echo "Reloading Environment Variables ...."
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

echo "`n`nStarting Keygenerator ...."
start-process java.exe -argumentlist "-jar keygen.jar"
echo "`n`nStarting Burp Suite Professional"

java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED -javaagent:"loader.jar" -noverify -jar "Burp-Suite-Pro.jar"
