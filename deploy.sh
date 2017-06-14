
sudo apt-get update

sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Update the apt package index.
sudo apt-get update

# Use this command to install the latest version of Docker
sudo apt-get install docker-ce

# Post installation scripts
# Create the docker group
sudo groupadd docker

# Add your user to the docker group
sudo usermod -aG docker $USER
