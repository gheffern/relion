FROM relion_base:gpu AS buildera
ENV CUDA_BIN_PATH=/usr/local/cuda/bin
RUN apt-get install -y \
       build-essential \
       cmake \
       git \
       libfftw3-dev \
       libtiff-dev \
       libpng-dev \
       mpi-default-dev \
  && apt-get clean \
  && su relion \
  && mkdir -p /opt/relion_build \
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

FROM relion_base:latest
RUN apt-get install -y \
      libtiff5 \
      libfftw3-double3 \
  && apt-get clean
USER relion
COPY --from=builder /opt/relion/ .
