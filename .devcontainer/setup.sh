#!/bin/bash

echo "Setting up AWS CLI..."

# Install AWS CLI v2
if ! command -v aws &> /dev/null; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws awscliv2.zip
fi

echo "AWS CLI Installed"

# Pre-configure AWS CLI if needed (e.g., default region or profile)
aws configure set region us-east-1
aws configure set output json

echo "AWS CLI setup complete."

pip install boto3
brew tap aws/tap
brew install aws-sam-cli

sudo wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Download the Docker CLI binary
curl -fsSL https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz -o docker.tgz

# Extract the binary
tar -xzf docker.tgz

# Move the Docker CLI binary to a directory in your PATH
sudo mv docker/docker /usr/local/bin/

# Clean up
rm -rf docker docker.tgz

# Download and extract eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# Move eksctl to /usr/local/bin
sudo mv /tmp/eksctl /usr/local/bin

# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Make it executable and move to /usr/local/bin
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install Terraform 

sudo wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Installing Java to Fix any Repo Mistakes  with BFG Cleaner

sudo apt update
sudo apt install default-jre -y

#  wget https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar -O bfg.jar  and  java -jar bfg.jar --strip-blobs-bigger-than 100M  are the commands to run 
