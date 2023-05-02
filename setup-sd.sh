#!/bin/bash

echo "Setting up Automatic111"

echo "Clone Automatic repo"

#mkdir workspace
#cd workspace
#git clone https://github.com/mithyalabs/stable-diffusion-webui.git

#cd ./stable-diffusion-webui

#echo "Installing dependencies"

# pip install -r ./requirements_versions.txt


# echo "Downloading SD1.5 model"
# wget https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt -P ./models/Stable-diffusion/


# wget https://huggingface.co/lllyasviel/ControlNet/resolve/main/models/control_sd15_normal.pth -P ./models/ControlNet/

echo "Updating packages"

sudo apt-get update -y

# sudo sed -i 's/try_files $uri $uri\/ =404;/proxy_pass http:\/\/localhost:7860;/' /etc/nginx/sites-available/default


sudo apt install python3-venv build-essential net-tools -y

wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda_12.0.0_525.60.13_linux.run
sudo sh cuda_12.0.0_525.60.13_linux.run --silent

sudo apt install nvidia-cuda-toolkit -y

sudo apt install ffmpeg -y


# Download ebsynth
mkdir /home/ubuntu/data/bin
wget https://pub-706bf4a189d94a6b8bfe844e4aaf385a.r2.dev/ebsynth_linux_cuda -O /home/ubuntu/data/bin/ebsynth
chmod +x /home/ubuntu/bin/ebsynth


echo "Installing controlnet extension"

git clone https://github.com/Mikubill/sd-webui-controlnet.git ./extensions/sd-webui-controlnet

echo "Downloading Canny model"
wget https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_canny.pth -P ./models/ControlNet/
wget https://huggingface.co/lllyasviel/ControlNet-v1-1/raw/main/control_v11p_sd15_canny.yaml -P ./models/ControlNet/


echo "Setting up ebsynth utility"

git clone -b feature/api https://github.com/mithyalabs/ebsynth_utility ./extensions/ebsynth_utility


echo "Setting up firewall"
sudo ufw allow 80
sudo ufw allow 22
sudo ufw enable

echo "Installing nginx"

sudo apt-get install nginx -y


# sudo chown root /home/ubuntu/nginx.conf
sudo mv ./nginx.conf /etc/nginx/sites-available/default -f
sudo service nginx reload