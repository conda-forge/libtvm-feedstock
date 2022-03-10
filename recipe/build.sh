#!/bin/env bash

# mkdir build
# cp cmake/config.cmake build
# cd build

# cmake .. -G Ninja \
#          -DCMAKE_PREFIX_PATH=$PREFIX \
#          -DCMAKE_BUILD_TYPE=Release \
#          -DCMAKE_INSTALL_PREFIX=$PREFIX \
#          -DCMAKE_INCLUDE_PATH=$PREFIX/include \
#          -DDLPACK_PATH=$PREFIX/include \
#          -DDMLC_PATH=$PREFIX/include \
#          -DRANG_PATH=$PREFIX/include \
#          -DUSE_CUDA=OFF \
#          -DUSE_VULKAN=OFF

         
# ninja -j${CPU_COUNT}
# ninja install


GPU_OPT=""
TOOLCHAIN_OPT=""

if [[ "$OSTYPE" == "darwin"* ]]; then
  OPTS="-DUSE_METAL=ON -DUSE_BLAS=apple -DUSE_BNNS=ON"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  if [[ "$cuda_compiler_version" != "None" ]]; then
    OPTS="-DUSE_CUDA=ON -DUSE_CUBLAS=ON -DUSE_CUDNN=ON -DUSE_CUTLASS=ON"
  fi
fi

rm -f config.cmake
rm -rf build || true
mkdir -p build
cd build

cmake .. -G Ninja \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INCLUDE_PATH=$PREFIX/include \
      -DDLPACK_PATH=$PREFIX/include \
      -DDMLC_PATH=$PREFIX/include \
      -DRANG_PATH=$PREFIX/include \
      -DUSE_RPC=ON \
      -DUSE_CPP_RPC=OFF \
      -DUSE_SORT=ON \
      -DUSE_RANDOM=ON \
      -DUSE_PROFILER=ON \
      -DUSE_LLVM=ON \
      -DINSTALL_DEV=ON \
      -DUSE_LIBBACKTRACE=AUTO \
      ${OPTS}

         
ninja -j${CPU_COUNT}
ninja install
