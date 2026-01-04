#!/bin/bash
set -e

# --------------------------------
# System update
# --------------------------------
apt update -y
apt upgrade -y

# --------------------------------
# Install utilities
# --------------------------------
apt install -y curl gnupg software-properties-common lsb-release fontconfig wget

# --------------------------------
# Java 21 installation
# --------------------------------
apt install -y openjdk-21-jre openjdk-21-jdk-headless

# Set JAVA_HOME globally
cat <<EOF > /etc/profile.d/java.sh
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export PATH=\$PATH:\$JAVA_HOME/bin
EOF

chmod +x /etc/profile.d/java.sh

# --------------------------------
# NGINX installation
# --------------------------------
apt install -y nginx
systemctl enable nginx
systemctl start nginx

# --------------------------------
# Terraform installation
# --------------------------------
curl -fsSL https://apt.releases.hashicorp.com/gpg \
  | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
  > /etc/apt/sources.list.d/hashicorp.list

apt update -y
apt install -y terraform

# --------------------------------
# Jenkins installation
# --------------------------------

# Add Jenkins GPG key
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" \
  > /etc/apt/sources.list.d/jenkins.list

# Install Jenkins
apt update -y
apt install -y jenkins

# Enable and start Jenkins
systemctl enable jenkins
systemctl start jenkins
