#!/bin/bash
extract_jdk(){
tar -xvf jdk-8u211-linux-arm64-vfp-hflt.tar.gz
mkdir -p /usr/lib/jvm
mv ./jdk1.8.0_211 /usr/lib/jvm/

update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_211/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_211/bin/javac" 1
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8.0_211/bin/javaws" 1

chmod a+x /usr/bin/java
chmod a+x /usr/bin/javac
chmod a+x /usr/bin/javaws
chown -R root:root /usr/lib/jvm/jdk1.8.0_211

cd ..

}

install_gamaweb(){

wget https://github.com/gama-platform/gama.cloud/releases/download/latest/GamaWeb.zip

apt install unzip

unzip GamaWeb.zip
mv GamaWeb/GamaWeb.war GamaWeb/offline_GamaWeb.war
chmod -R +777 GamaWeb
cd GamaWeb
java -jar tomcat_launcher.jar "/offline_GamaWeb" "offline_GamaWeb.war"
}
if [ -e ${/usr/lib/jvm/jdk1.8.0_211} ]
then
install_gamaweb
else
extract_jdk
install_gamaweb
fi
