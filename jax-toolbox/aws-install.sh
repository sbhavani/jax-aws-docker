#!/bin/bash

export EFA_INSTALLER_VERSION=latest
export AWS_OFI_NCCL_VERSION=aws

cd /tmp && curl -O https://efa-installer.amazonaws.com/aws-efa-installer-${EFA_INSTALLER_VERSION}.tar.gz  && tar -xf aws-efa-installer-${EFA_INSTALLER_VERSION}.tar.gz \
&& cd aws-efa-installer && (cd DEBS/UBUNTU2204/x86_64/ && rm -rf debug/* ibacm* libib[umn]* infiniband* librdma* openmpi*)  && apt-get purge -y ibverbs-providers libibverbs-dev libibverbs1 \
&& apt update && ./efa_installer.sh -g -y --skip-kmod --skip-limit-conf --no-verify | tee /workspace/aws-efa-install.log \
&& rm -rf /tmp/aws-efa-installer /var/lib/apt/lists/* \
&& /opt/amazon/efa/bin/fi_info --version

export LD_LIBRARY_PATH=/opt/amazon/efa/lib:$LD_LIBRARY_PATH
export PATH=/opt/amazon/efa/bin:$PATH

cd /tmp && git clone https://github.com/nvidia/nccl.git /tmp/nccl  && cd /tmp/nccl  && git checkout v$(echo ${NCCL_VERSION} | cut -d "+" -f 1)-1 \
&& git clone https://github.com/aws/aws-ofi-nccl.git /tmp/aws-ofi-nccl \
&& cd /tmp/aws-ofi-nccl && git checkout ${AWS_OFI_NCCL_VERSION} \
&& bash ./autogen.sh \
&& CPPFLAGS="-I/tmp/nccl/src/include" ./configure --prefix=/usr/local        --with-libfabric=/opt/amazon/efa/        --with-cuda=/usr/local/cuda        --with-nccl=/usr        --with-mpi=/usr/local/mpi \
&& make -j$(nproc) install \
&& rm -rf /tmp/nccl /tmp/aws-ofi/nccl \
&& cd /tmp && git clone https://github.com/NVIDIA/nccl-tests.git /tmp/nccl-tests \
&& cd /tmp/nccl-tests/ && make -j$(nproc) MPI=1 MPI_HOME=/usr/local/mpi \
&& cp -r build/* /usr/local/bin

