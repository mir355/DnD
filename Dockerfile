FROM tensorflow/tensorflow:latest

# CMD /path/run.sh
# RUN echo hello

# WORKDIR /playground
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
RUN apt-get update && apt-get install -y git

# benchmarks
RUN git clone https://github.com/onnx/models.git /app/zoo
RUN git clone https://github.com/mlcommons/tiny.git --branch=v0.7 /app/tiny

# compilers
RUN apt-get install -y python3 python3-dev python3-setuptools gcc libtinfo-dev zlib1g-dev build-essential cmake libedit-dev libxml2-dev
RUN git clone --recursive https://github.com/apache/tvm /app/tvm
RUN git clone --recursive https://github.com/pytorch/glow /app/glow
RUN apt-get install -y clang clang-8 cmake graphviz libpng-dev \
    libprotobuf-dev llvm-8 llvm-8-dev ninja-build protobuf-compiler wget \
    opencl-headers libgoogle-glog-dev libboost-all-dev \
    libdouble-conversion-dev libevent-dev libssl-dev libgflags-dev \
    libjemalloc-dev libpthread-stubs0-dev liblz4-dev libzstd-dev libbz2-dev \
    libsodium-dev libfmt-dev
RUN update-alternatives --install /usr/bin/clang clang \
    /usr/lib/llvm-8/bin/clang 50
RUN update-alternatives --install /usr/bin/clang++ clang++ \
    /usr/lib/llvm-8/bin/clang++ 50
RUN update-alternatives --config cc
RUN update-alternatives --config c++
RUN cd /app/glow && cmake -G Ninja -S . -B build && cd build && ninja all
RUN cd /app/tvm && cmake -G Ninja -S . -B build && cd build && ninja

RUN git clone https://github.com/purseclab/DnD /app/dnd

# ADD . /app/dnd

CMD ["bash"]
