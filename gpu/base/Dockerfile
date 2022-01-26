# syntax=docker/dockerfile:1.2
FROM nvidia/cuda:11.6.0-devel-ubuntu20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt apt-get update \
  && apt-get install -y \
       mpi-default-bin \
       vim \
  && apt-get clean \
  && useradd -ms /bin/bash relion \
  && mkdir -p /opt/relion/\
  && chown relion:relion /opt/relion
WORKDIR /opt/relion

