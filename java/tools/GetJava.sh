#!/bin/bash

function fetch {
 url=$1
 dest=$2
 echo "Fetch $url in $dest"
 mkdir -p "$dest"
 rm -Rf /tmp/extJVM29dk03
 mkdir -p /tmp/extJVM29dk03
 file="${url##*/}"
 ext="${file##*.}"
 curl "$url" -o /tmp/vm.tmp
 if [ "$ext" = "zip" ];
 then
 	unzip -o /tmp/vm.tmp -d /tmp/extJVM29dk03/
 else
    tar -xf /tmp/vm.tmp -C /tmp/extJVM29dk03/
 fi
 mv /tmp/extJVM29dk03/*/* "$dest/"
}

# GetJava.sh linux64 jdk8 vms/jdk8/

PLATFORM=$1
TYPE=$2
DEST=$3

echo "Platform $PLATFORM type $TYPE dest $DEST"

declare -A jdk8=( 
  	[linux64]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jdk8.0.222-linux_x64.tar.gz" 
	[linux32]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jdk8.0.222-linux_i686.tar.gz" 
	[linuxArm64]="https://cdn.azul.com/zulu-embedded/bin/zulu8.40.0.178-ca-jdk1.8.0_222-linux_aarch64.tar.gz"
	[linuxArmHF]="https://cdn.azul.com/zulu-embedded/bin/zulu8.40.0.178-ca-jdk1.8.0_222-linux_aarch32hf.tar.gz" 
	[linuxArm]="https://cdn.azul.com/zulu-embedded/bin/zulu8.40.0.178-ca-jdk1.8.0_222-linux_aarch32sf.tar.gz" 

	[win64]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jdk8.0.222-win_x64.zip"
	[win32]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jdk8.0.222-win_i686.zip"
)

declare -A jdk11=(
  	[linux64]="https://cdn.azul.com/zulu/bin/zulu11.33.15-ca-jdk11.0.4-linux_x64.tar.gz" 
	[linuxArm64]="https://cdn.azul.com/zulu-embedded/bin/zulu11.33.21-ca-jdk11.0.4-linux_aarch64.tar.gz"
	[linuxArmHF]="https://cdn.azul.com/zulu-embedded/bin/zulu11.33.21-ca-jdk11.0.4-linux_aarch32hf.tar.gz" 
	[linuxArm]="https://cdn.azul.com/zulu-embedded/bin/zulu11.33.21-ca-jdk11.0.4-linux_aarch32sf.tar.gz" 

	[win64]="https://cdn.azul.com/zulu/bin/zulu11.33.15-ca-jdk11.0.4-win_x64.zip"
)

declare -A jre8=(
	[linux64]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jre8.0.222-linux_x64.tar.gz"
    [linux32]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jre8.0.222-linux_i686.tar.gz"
	
    [win64]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jre8.0.222-win_x64.zip"
    [win32]="https://cdn.azul.com/zulu/bin/zulu8.40.0.25-ca-jre8.0.222-win_i686.zip"
)

declare -A jre11=(
	[linux64]="https://cdn.azul.com/zulu/bin/zulu11.33.15-ca-jre11.0.4-linux_x64.tar.gz"
	
    [win64]="https://cdn.azul.com/zulu/bin/zulu11.33.15-ca-jre11.0.4-win_x64.zip"
)


url=""
v="\${$TYPE[\$PLATFORM]}"
url=`eval echo "$v"`
echo "Url: $url"

fetch "$url" "$DEST"
