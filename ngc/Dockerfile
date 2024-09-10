FROM nvcr.io/nvidia/tensorrt:24.08-py3
#FROM nvcr.io/nvidia/pytorch:24.08-py3

# additional packages needed for AWS
RUN apt-get update && apt install autoconf automake libtool -y

# AWS deps
COPY aws-install.sh /workspace
RUN chmod u+x /workspace/aws-install.sh
RUN /workspace/aws-install.sh

## SageMaker related testing
RUN pip install torch deepspeed
RUN mkdir -p /opt/ml/code
WORKDIR /opt/ml/code
RUN git clone https://github.com/EleutherAI/cookbook
COPY test-allreduce.sh /opt/ml/code/test-allreduce.sh
ENV SAGEMAKER_PROGRAM test-allreduce.sh

ENTRYPOINT ["bash", "/opt/ml/code/test-allreduce.sh"]
