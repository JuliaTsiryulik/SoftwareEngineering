FROM ubuntu
ENV TZ=Europe/Moscow
RUN apt-get clean && apt-get update -y 
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata git sudo build-essential autoconf libtool libssl-dev zlib1g-dev librdkafka-dev pkg-config cmake gcc git g++ mysql-client libmysqlclient-dev libboost-all-dev libssl-dev && apt-get clean
RUN git clone -b master https://github.com/pocoproject/poco.git && cd poco && mkdir cmake-build && cd cmake-build && cmake .. && make && sudo make install && cd .. && cd ..
ARG build1=$RANDOM
RUN git clone https://github.com/JuliaTsiryulik/SoftwareEngineering.git
RUN sudo ldconfig
RUN cd SoftwareEngineering/Messenger/P2PService && mkdir build && cd build && cmake  .. && make
ENTRYPOINT [ "SoftwareEngineering/Messenger/P2PService/build/P2PService" ]
