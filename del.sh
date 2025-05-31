#!/bin/bash

echo "Stopping all running containers..."
docker stop $(docker ps -q)

echo "Removing all containers..."
docker rm $(docker ps -a -q)

echo "Removing all images..."
docker rmi -f $(docker images -q)

echo "Removing all volumes..."
docker volume rm $(docker volume ls -q)

echo "Docker cleanup complete."

sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli containerd runc
sudo apt-get autoremove -y
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
docker --version

pip uninstall tutor
rm -rf ~/.local/share/tutor
rm -rf ~/.config/tutor ~/.cache/tutor
rm -rf ~/.local/lib/python*/site-packages/tutor*
rm -rf ~/.local/share/tutor
rm -rf ~/.config/tutor
rm -rf ~/.cache/tutor

which tutor

