#!/bin/bash

mkdir build
cd build

cmake .. -G Ninja \
         -DCMAKE_PREFIX_PATH=$PREFIX \
         -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_INSTALL_PREFIX=$PREFIX \
         -DCMAKE_INCLUDE_PATH=$PREFIX/include \
         -DDLPACK_PATH=$PREFIX/include \
         -DDMLC_PATH=$PREFIX/include \
         -DRANG_PATH=$PREFIX/include \
         -DUSE_CUDA=OFF \
         -DUSE_VULKAN=OFF

         
ninja -j${CPU_COUNT}
ninja install

ACTIVATE_DIR=${PREFIX}/etc/conda/activate.d
DEACTIVATE_DIR=${PREFIX}/etc/conda/deactivate.d
mkdir -p ${ACTIVATE_DIR}
mkdir -p ${DEACTIVATE_DIR}

cp ${RECIPE_DIR}/scripts/activate.sh ${ACTIVATE_DIR}/tvm-activate.sh
cp ${RECIPE_DIR}/scripts/deactivate.sh ${DEACTIVATE_DIR}/tvm-deactivate.sh
