FROM debian:bullseye-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y \
       mpi-default-bin \
       vim \
  && apt-get clean \
  && useradd -ms /bin/bash relion \
  && mkdir -p /opt/relion/\
  && chown relion:relion /opt/relion
WORKDIR /opt/relion

