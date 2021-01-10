FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y \
       build-essential \
       cmake \
       git \
       libfftw3-dev \
       libtiff-dev \
       libpng-dev \
       mpi-default-bin \
       mpi-default-dev \
       vim \
  && apt-get clean \
  && useradd -ms /bin/bash relion \
  && mkdir -p /opt/relion_build/ /opt/relion/\
  && chown relion:relion /opt/relion \
  && su relion \
  && cd /opt/relion_build \
  && git clone  https://github.com/3dem/relion.git . \
  && sed -i '218,222d' CMakeLists.txt \
  && mkdir build \
  && cd build \
  && export CXX=mpicxx \
  && cmake -DGUI=OFF -DCMAKE_INSTALL_PREFIX=/opt/relion/ .. \
  && export cpu_count=$(lscpu -p | grep -v '#' | wc -l) \
  && make -j $cpu_count \
  && make install
USER relion
WORKDIR /opt/relion

