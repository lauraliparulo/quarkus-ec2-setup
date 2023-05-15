#!/bin/bash
# This script allows you to set up the tools you need to run Quarkus projects on an Ubuntu Instance 
#You just need to run it once!
# --------------------------------------------------------------------------------------------------
#--- DOCKER ----------------- taken from https://docs.docker.com/engine/install/ubuntu/
echo 'Installing docker...'
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#add permissions for the Docker socket file (for mvn)
sudo chmod 666 /var/run/docker.sock
#--- GIT --------------------------------------------------------------
echo 'Installing git...'
sudo apt-get install git
echo 'Check git version:'
git -version

#--- GRAAL VM - JAVA 17-------------------------------------------------------------
echo 'Installing graalVM.."
wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.2/graalvm-ce-java17-linux-amd64-22.3.2.tar.gz
tar -xzf graalvm-ce-java17-linux-amd64-22.3.2.tar.gz
sudo mv graalvm-ce-java17-linux-amd64-22.3.2 /opt/
export JAVA_HOME=/opt/graalvm-ce-java17-22.3.2
#--- MAVEN -------------------------------------------------------
wget https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz
tar -xzf apache-maven-3.9.2-bin.tar.gz
sudo mv apache-maven-3.9.2 /opt/
M2_HOME='/opt/apache-maven-3.9.2'


export PATH=/home/ubuntu/graalvm-ce-java17-22.3.2/bin:$PATH
export PATH="$M2_HOME/bin:$PATH"

echo 'Check java version is GRAAL'
java -version
echo 'Check mvn version'
mvn -version



# TODO append export to bash profile