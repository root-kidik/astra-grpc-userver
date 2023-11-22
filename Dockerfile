FROM dockerhub.lemz.t/library/astralinux:ce2.12.22-gcc11.3.0-qt5.15.6-cmake3.22.6
RUN echo "deb http://dl.astralinux.ru/astra/frozen/2.12_x86-64/2.12.22/repository/ orel main contrib non-free" >> /etc/apt/sources.list 
RUN apt-get update && apt-get -y install debian-archive-keyring dirmngr
RUN echo "deb [trusted=yes] http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list
RUN apt update
RUN apt -y -o Dpkg::Options::="--force-confnew" upgrade 
RUN apt -f install
RUN apt -y install ccache cmake git libbenchmark-dev libboost-filesystem1.74-dev libboost-iostreams1.74-dev libboost-locale1.74-dev libboost-program-options1.74-dev libboost-regex1.74-dev libboost1.74-dev libbson-dev libc-ares-dev libcctz-dev libcrypto++-dev libcurl4-openssl-dev libev-dev libfmt-dev libgmock-dev libgrpc-dev libgrpc++-dev libgrpc++1 libgtest-dev libhiredis-dev libhttp-parser-dev libjemalloc-dev libkrb5-dev libldap2-dev libmongoc-dev libnghttp2-dev libpq-dev libprotoc-dev libssl-dev libyaml-cpp-dev postgresql-13 postgresql-server-dev-13 protobuf-compiler-grpc python3-dev python3-jinja2 python3-protobuf python3-virtualenv python3-voluptuous python3-yaml redis-server virtualenv zlib1g-dev
RUN useradd admin && su admin
WORKDIR /app
COPY ./src ./src 
COPY ./configs ./configs
COPY ./proto ./proto
COPY ./tests ./tests
COPY ./Makefile ./Makefile
COPY ./Makefile.local ./Makefile.local
COPY ./CMakeLists.txt ./CMakeLists.txt
COPY ./third_party ./third_party
RUN cd third_party/backtrace/libbacktrace && cmake .. && cmake --build . && make install 
RUN export PATH="/usr/local/lib:/usr/local/include:/usr/local/include/libbacktrace:$PATH" 
RUN make build-debug -j16
RUN make test-debug -j16
