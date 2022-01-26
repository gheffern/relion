FROM relion_base:gpu AS builder

ENV CMAKE_C_COMPILER=mpicc
ENV CMAKE_CXX_COMPILER=mpicxx
RUN    apt-get install -y \
       build-essential \
       cmake \
       git \
       libfftw3-dev \
       libtiff-dev \
       libpng-dev \
       mpi-default-dev \
       libx11-dev \
       libfreetype6-dev\
       pkg-config \
  && apt-get clean \
  && su relion \
  && mkdir -p /opt/relion_build/ \
  && cd /opt/relion_build \
  && git clone  https://github.com/3dem/relion.git . \
  && git checkout 'ver4.0' 
RUN cd /opt/relion_build/ \
  && mkdir build \
  && cd build \
  && echo ${PWD} \
  && cmake -DCMAKE_INSTALL_PREFIX=/opt/relion/ .. \
  && export cpu_count=$(lscpu -p | grep -v '#' | wc -l) \
  && make -j $cpu_count \
  && make install
USER relion

FROM nvidia/cuda:11.6.0-runtime-ubuntu20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y \
      mpi-default-bin \
      libpng16-16 \
      libtiff5 \
      libfftw3-double3 \
      libfftw3-3 \
      vim \
  && apt-get clean \
  && useradd -ms /bin/bash relion \
  && mkdir -p /opt/relion/\
  && chown relion:relion /opt/relion
USER relion
WORKDIR /opt/relion
COPY --from=builder /opt/relion/ .
