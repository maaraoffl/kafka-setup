
sudo apt-get --assume-yes update

# Install git
sudo apt-get install git

# Git clone setup
git clone https://github.com/maheshveera/dockersetup.git -b development

sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get --assume-yes install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package index.
sudo apt-get --assume-yes update

# Use this command to install the latest version of Docker
sudo apt-get --assume-yes install docker-ce

# Post installation scripts
# Create the docker group
sudo groupadd docker

# Add your user to the docker group
sudo usermod -aG docker $USER


cd dockersetup

# Deploying elasticsearch & kibana
docker stack deploy -c monitoring-components-stack.yml monitors

# Deploying swarm log aggregators
docker stack deploy -c swarm-monitor-stack.yml swarmx

# Preparing kafka container deployment
docker build -t kafkadocker_kafka .
export HOST_IP_ADDRESS=$(curl "http://169.254.169.254/latest/meta-data/public-ipv4")

# Set KNODE_IP_ADDRESS
export KNODE_IP_ADDRESS=???

docker stack deploy -c kafka-stack.yml kafka

# Pull customized logstash-jmx image
# Optional
docker pull dironman/logstash-jmx

# Set label for kafka node
#docker node update --label-add SwarmNodeName=kafka ksgwy2cela7n88kfwxudzp68q # replace with kafka swarm node Id

export ZOOKEEPER_ADDRESS=${HOST_IP_ADDRESS}:2181
export KAFKA_BROKER_LIST=${HOST_IP_ADDRESS}:9092
