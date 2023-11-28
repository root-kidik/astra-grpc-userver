FROM greeter-service:latest
RUN echo "deb http://deb.debian.org/debian buster main contrib non-free" >> /etc/apt/sources.list 
RUN echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 605C66F00D6C9793 0E98404D386FA1D9 648ACFD622F3D138
RUN apt -y update && apt -y -o Dpkg::Options::="--force-confnew" upgrade
RUN apt -y install ccache cmake git libbenchmark-dev libboost-filesystem1.67-dev libboost-iostreams1.67-dev libboost-locale1.67-dev libboost-program-options1.67-dev libboost-regex1.67-dev libboost1.67-dev libbson-dev libc-ares-dev libcctz-dev libcrypto++-dev libcurl4-openssl-dev libev-dev libfmt-dev libgmock-dev libgrpc-dev libgrpc++-dev libgrpc++1 libgtest-dev  libhttp-parser-dev libjemalloc-dev libkrb5-dev libldap2-dev  libnghttp2-dev libpq-dev libprotoc-dev libssl-dev libyaml-cpp-dev protobuf-compiler-grpc python3-dev python3-jinja2 python3-protobuf python3-virtualenv python3-voluptuous python3-yaml  virtualenv zlib1g-dev g++
RUN apt -y install boost1.74/buster-backports cmake/buster-backports
RUN useradd -ms /bin/bash admin
USER admin
WORKDIR /home/admin
COPY ./configs/ ./configs/
COPY ./proto/ ./proto/
COPY ./src/ ./src/
COPY ./third_party/ ./third_party/
COPY ./tests/ ./tests/
COPY ./Makefile ./Makefile
COPY ./Makefile.local ./Makefile.local
COPY ./CMakeLists.txt ./CMakeLists.txt
RUN make build-debug

# 1. git submodule update --init
# 2. docker run -d -t greeter-service
