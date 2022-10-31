FROM tensorflow/tensorflow:latest

# CMD /path/run.sh
# RUN echo hello

# WORKDIR /playground
RUN apt-get update && apt-get install -y git openssl libssl-dev
RUN apt-get install -y python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential libedit-dev libxml2-dev
RUN apt-get install -y clang cmake graphviz libpng-dev \
    libprotobuf-dev llvm llvm-dev ninja-build protobuf-compiler wget \
    opencl-headers libgoogle-glog-dev libboost-all-dev \
    libdouble-conversion-dev libevent-dev libssl-dev libgflags-dev \
    libjemalloc-dev libpthread-stubs0-dev liblz4-dev libzstd-dev libbz2-dev \
    libsodium-dev # libfmt-dev
RUN update-alternatives --install /usr/bin/clang clang \
    /usr/lib/llvm-10/bin/clang 50
RUN update-alternatives --install /usr/bin/clang++ clang++ \
    /usr/lib/llvm-10/bin/clang++ 50

# python3
RUN /usr/bin/python3 -m pip install --upgrade pip
RUN /usr/bin/python3 -m pip install pytest
RUN /usr/bin/python3 -m pip install tflite2onnx
RUN /usr/bin/python3 -m pip install tf2onnx
RUN /usr/bin/python3 -m pip install yapf
RUN /usr/bin/python3 -m pip install argparse
RUN /usr/bin/python3 -m pip install onnx
RUN /usr/bin/python3 -m pip install numpy
RUN /usr/bin/python3 -m pip install angr
RUN /usr/bin/python3 -m pip install archinfo
RUN /usr/bin/python3 -m pip install claripy
RUN /usr/bin/python3 -m pip install traitlets

# cmake stable latest
# RUN git clone https://github.com/Kitware/CMake.git --branch=v3.24.0 /app/cmake
# RUN cd /app/cmake && ./bootstrap && make && make install

RUN apt-get install gpg wget
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ focal main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null && apt-get update
RUN rm /usr/share/keyrings/kitware-archive-keyring.gpg
RUN apt-get install -y kitware-archive-keyring
RUN apt-get install -y cmake
# RUN cmake --version

# benchmarks
RUN git clone https://github.com/onnx/models.git /app/zoo
RUN git clone https://github.com/mlcommons/tiny.git --branch=v0.7 /app/tiny

# compilers
RUN git clone --recursive https://github.com/apache/tvm /app/tvm
RUN cd /app/tvm && cmake -G Ninja -S . -B build && cd build && ninja

RUN git clone https://github.com/fmtlib/fmt /app/fmt
RUN cd /app/fmt && cmake -S . -B build && cd build && make && make install
RUN git clone --recursive https://github.com/pytorch/glow /app/glow \
  && cd /app/glow/thirdparty/folly \
  && git pull origin main
RUN cd /app/glow && export CC=clang && export CXX=clang++ && cmake -G Ninja -S . -B build && cd build && ninja all

# RUN git clone https://github.com/FailFish/DnD /app/dnd
# RUN apt-get install git-lfs

ENV PATH="${PATH}:/app/glow/build/bin"

# ADD . /app/dnd

CMD ["bash"]
