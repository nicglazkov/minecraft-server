# How to install Minecraft on Google Cloud Platform
* `backup.sh` -- Script that makes backups of world files and deletes backups that are 7 days or older
* `minecraft.service` -- systemd script to make minecraft a service
## Install Java
```bash
sudo apt update && sudo apt upgrade -y
sudo apt-get install software-properties-common
sudo apt-get install wget
wget -O- https://apt.corretto.aws/corretto.key | sudo apt-key add -
sudo add-apt-repository 'deb https://apt.corretto.aws stable main'
sudo apt-get update
sudo apt-get install -y java-17-amazon-corretto-jdk
```
## Setup Paper
```bash
mkdir paper
cd paper
curl -L -o paper.jar https://papermc.io/api/v2/projects/paper/versions/1.18.1/builds/121/downloads/paper-1.18.1-121.jar
java -jar paper.jar
```
Agree to eula

## Server config
```bash
screen java -Xms4G -Xmx10G -jar paper.jar --nogui
To detach: control+a+d
To reattach: screen -r
```
To update `minecraft.service`
```
sudo cp minecraft.service /etc/systemd/system/minecraft.service
```
## Auto restart
```bash
sudo useradd -r -m -d /opt/minecraft minecraft
sudo vim /etc/systemd/system/minecraft.service
sudo mv paper /opt/minecraft/
sudo chown -R minecraft:minecraft /opt/minecraft/paper 
sudo systemctl start minecraft
sudo systemctl stop minecraft
sudo systemctl restart minecraft
sudo systemctl enable minecraft
```
## Periodic restart
```bash
sudo su
crontab -e
0 12 * * * /bin/systemctl restart minecraft
```
## Server scripts
```bash
cp backup.sh /opt/minecraft
```
