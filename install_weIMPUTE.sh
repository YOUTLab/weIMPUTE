#!/bin/bash

# Function to check if Docker is installed
check_docker() {
  if command -v docker &> /dev/null; then
    echo "Docker is already installed."
  else
    echo "Docker is not installed. Installing..."
    case "$OS" in
    Ubuntu*)
      install_docker_ubuntu
      ;;
    CentOS*|RHEL*)
      install_docker_centos
      ;;
    *)
      echo "Unsupported OS: $OS"
      ;;
  esac
  fi
}

# Function to install Docker on Ubuntu
install_docker_ubuntu() {
  sudo ufw allow 9083/tcp
  sudo ufw allow 9085/tcp
  sudo ufw enable
  sudo apt-get update -y
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  sudo apt-get update
  sudo apt-get install -y docker-ce
}

# Function to install Docker on CentOS
install_docker_centos() {
  sudo firewall-cmd --permanent --add-port=9083/tcp
  sudo firewall-cmd --permanent --add-port=9085/tcp
  sudo firewall-cmd --reload
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install -y docker-ce docker-ce-cli containerd.io
}

# Detect the OS
detect_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
  else
    echo "Cannot detect the OS."
    exit 1
  fi
}

# Download software
install_software(){
  echo "start install software"
  if [ -e suanfa_v6.tar ]; then
    echo "The software package already exists."
  else
      wget http://144.34.160.128:82/suanfa_v6.tar
  fi
  
  echo "start load software..."
  if docker inspect [suanfa] > /dev/null 2>&1; then
    echo "image already exists"
  else
    sudo docker load -i suanfa_v6.tar
  fi
  
  sudo docker run -d --privileged -p 9083:9083 -p 9085:9085 --restart=always suanfa:v6
  ##get the ID of the current Docker
  CONTAINER_ID=$(sudo docker ps -a | grep "suanfa:v6" | awk '{print $1}' | sed -n '1p')

  ## start nginx
  sudo docker exec $CONTAINER_ID /bin/bash -c '/usr/local/nginx/sbin/nginx'

  ## start mysql
  sudo docker exec $CONTAINER_ID /bin/bash -c '/etc/init.d/mysqld start'

  ## start redis
  sudo docker exec $CONTAINER_ID /bin/bash -c '/usr/local/bin/redis-server /usr/local/redis/redis.conf'

  ## start java
  sudo docker exec $CONTAINER_ID /bin/bash -c 'nohup /usr/local/jdk/bin/java -Xms256m -Xmx512m -jar /usr/local/src/suanfa/jiyin-admin.jar > /usr/local/src/suanfa/suanfa.log 2>&1'

  echo "Software installation completed successfully."

}

# Main script
detect_os
check_docker

# Start Docker service and enable it to start on boot
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
docker --version
echo "Docker installation completed successfully."

install_software

echo "Please use your browser to visit http://ip:9083 and http://ip:9085"

