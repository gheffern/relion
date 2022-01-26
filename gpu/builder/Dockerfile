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

FROM relion_base:gpu
RUN apt-get install -y \
      libtiff5 \
      libfftw3-double3 \
  && apt-get clean
USER relion
COPY --from=builder /opt/relion/ .
