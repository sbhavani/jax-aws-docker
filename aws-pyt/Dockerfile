FROM 763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-training:2.3.0-gpu-py311-cu121-ubuntu20.04-ec2

## SageMaker related testing
RUN pip install deepspeed
RUN mkdir -p /opt/ml/code
WORKDIR /opt/ml/code
RUN git clone https://github.com/EleutherAI/cookbook
COPY test-allreduce.sh /opt/ml/code/test-allreduce.sh
ENV SAGEMAKER_PROGRAM test-allreduce.sh

ENTRYPOINT ["bash", "/opt/ml/code/test-allreduce.sh"]
