##Overview
1;95;0cBased on https://github.com/aws/deep-learning-containers/blob/master/pytorch/training/docker/2.3/py3/cu121/Dockerfile.gpu

Note: You need to authenticate to pull an image from an Amazon Elastic Container Registry (ECR) repository.

```bash
snap install aws-cli --classic
aws configure
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 763104351884.dkr.ecr.us-east-1.amazonaws.com

##Packages
OS_VERSION="20.04.6 LTS"
PYTHON_VERSION=3.11.9
CUDA_VERSION=12.1.r12.1
CUDNN_VERSION=8.9.2.26
NCCL_VERSION=2.21.5
EFA_VERSION=1.32.0
OPENMPI_VERSION=4.1.6
TORCH_VERSION=2.3.0
