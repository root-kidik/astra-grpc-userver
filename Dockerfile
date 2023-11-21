FROM --platform=linux/amd64 dockerhub.lemz.t/library/astralinux:ce2.12.22-gcc11.3.0-qt5.15.6-cmake3.22.6
RUN echo "deb http://dl.astralinux.ru/astra/frozen/2.12_x86-64/2.12.22/repository/ orel main contrib non-free" >> /etc/apt/sources.list 
RUN apt-get update && apt-get -y install debian-archive-keyring dirmngr
RUN echo "deb [trusted=yes] http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list
RUN apt upgrade # new
RUN apt install libgrpc++-dev
RUN apt update && apt upgrade && apt autoremove
RUN apt -y install 
COPY test.sh /test.sh
CMD chmod 777 test.sh && ./test.sh 
#RUN apt -y install libboost-regex1.67-dev
#WORKDIR /app
#COPY ./src ./src 
#COPY ./configs ./configs
#COPY ./proto ./proto
#COPY ./tests ./tests
#COPY ./Makefile ./Makefile
#COPY ./Makefile.local ./Makefile.local
#COPY ./CMakeLists.txt ./CMakeLists.txt
#COPY ./third_party ./third_party/
#CMD make test-debug -j16
# libboost-context1.65-dev libboost-coroutine1.65-dev libboost-filesystem1.65-dev libboost-iostreams1.65-dev libboost-locale1.65-dev libboost-program-options1.65-dev libboost-regex1.65-dev libboost1.65-dev
