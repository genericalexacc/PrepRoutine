sudo apt-get update
sudo apt-get install \
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
sudo apt-get install docker-ce

wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
sudo dpkg -i cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb
sudo apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
sudo apt-get update
sudo apt-get install -y cuda
rm cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb

wget http://developer.download.nvidia.com/compute/redist/cudnn/v7.0.5/cudnn-9.0-linux-x64-v7.tgz
sudo tar -xzf cudnn-9.0-linux-x64-v7.tgz -C /usr/local
rm cudnn-9.0-linux-x64-v7.tgz
sudo ldconfig

export CUDA_HOME=/usr/local/cuda-9.0
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:/usr/local/cuda/lib64:${LD_LIBRARY_PATH}

#sudo apt-get install -y python-pip python-dev
#sudo pip install tensorflow-gpu

wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

git clone https://github.com/abhishekrana/MaskRCNN_Tensorflow_Docker.git
cd MaskRCNN_Tensorflow_Docker
python3 ./install.py

sudo nvidia-docker exec -it user-mrcnn_tf1.1 bash -c "cd MRCNN/FastMaskRCNN; python train/train.py"


