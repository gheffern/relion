# syntax=docker/dockerfile:1 
FROM nvidia/cuda:11.6.0-devel-ubuntu20.04 AS builder

ARG CMAKE_C_COMPILER=mpicc \
    CMAKE_CXX_COMPILER=mpicxx \
    DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt apt-get update \
  &&   apt-get install -y \
         mpi-default-bin \
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
  && useradd -ms /bin/bash relion \
  && su relion \
  && mkdir -p /opt/relion_build/ \
  && cd /opt/relion_build \
  && git clone  https://github.com/3dem/relion.git . \
  && git checkout 'ver4.0' \
  && mkdir build \
  && cd build \
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
