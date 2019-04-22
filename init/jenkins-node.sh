cd /home
wget http://192.168.0.135:8080/Maven/apache-maven-3.5.3-bin.zip
unzip apache-maven-3.5.3-bin.zip
mv apache-maven-3.5.3 maven
cd maven/conf/
wget -Osettings.xml http://git.internal.sixi.com/jtb/script/raw/master/conf/maven.xml
cd /home
wget -Ojdk.rpm http://192.168.0.135:8080/JAVA/JDK/jdk-8u162-linux-x64.rpm
rpm -ivh jdk.rpm