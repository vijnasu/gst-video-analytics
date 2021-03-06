#!/bin/bash
# ==============================================================================
# Copyright (C) 2018-2019 Intel Corporation
#
# SPDX-License-Identifier: MIT
# ==============================================================================

build_type=${1:-opensource}
tag=${2:-latest}

if [ $build_type == "opensource" ]; then
  dockerfile=Dockerfile
elif [ $build_type == "package" ]; then
  dockerfile=binaries.Dockerfile
else
  echo "Usage: ./build_docker_image.sh [BUILDTYPE] [TAG]"
  echo "ERROR: please set BUILDTYPE to on of the following: [opensource, package]"
  exit
fi

BASEDIR=$(dirname "$0")
docker build -f ${BASEDIR}/${dockerfile} -t gstreamer-plugins:$tag \
    --build-arg http_proxy=${HTTP_PROXY} \
    --build-arg https_proxy=${HTTPS_PROXY} \
    ${BASEDIR}/..
