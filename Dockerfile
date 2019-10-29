FROM python:3.8.0 as builder

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y make git zlib1g-dev libssl-dev gperf php cmake clang \
       libc++-dev libc++abi-dev && \
    git clone https://github.com/tdlib/td.git /tmp/td && \
    rm -rf /tmp/td/build && \
    mkdir -p /tmp/td/build && \
    export CXXFLAGS="-stdlib=libc++" && \
    cd /tmp/td/build && \
    CC=/usr/bin/clang CXX=/usr/bin/clang++ cmake -DCMAKE_BUILD_TYPE=Release \
       -DCMAKE_INSTALL_PREFIX:PATH=../tdlib .. && \
    cmake --build . --target install

FROM python:3.8.0

COPY --from=builder /tmp/td/tdlib/include/td /usr/include/
COPY --from=builder /tmp/td/tdlib/lib/* /usr/lib/

RUN apt-get update && \
    apt install -y libc++abi1-7 libc++1-7 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade pip && \
    pip install virtualenv
