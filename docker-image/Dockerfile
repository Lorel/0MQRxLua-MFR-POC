FROM ubuntu:16.04
MAINTAINER aurelien.havet@unine.ch
WORKDIR /root


RUN apt-get update && \
  apt-get install -y git gcc g++ make cmake lua5.1 liblua5.1-0 liblua5.1-0-dev libzmq5-dev wget chrpath libzmq5-dev && \
  git clone https://github.com/Lorel/lzmq.git && \
  cd lzmq && \
  mkdir cmake-make && \
  cd cmake-make && \
  cmake .. && \
  make install && \
  rm -rf /root/lzmq/ && \
  cd /root && \
  wget https://www.kyne.com.au/~mark/software/download/lua-cjson-2.1.0.tar.gz && \
  tar -xvf lua-cjson-2.1.0.tar.gz && \
  rm lua-cjson-2.1.0.tar.gz && \
  cd lua-cjson-2.1.0 && \
  mkdir cmake-make && \
  cd cmake-make && \
  cmake .. && \
  make install && \
  rm -rf /root/lua-cjson-2.1.0 && \
  mkdir -p /usr/local/lib/lua/5.1/ && \
  mv /usr/local/lib/lua/lzmq /usr/local/lib/lua/5.1/lzmq && \
  mv /usr/local/lib/lua/lzmq.so /usr/local/lib/lua/5.1/lzmq.so && \
  mv /usr/lib/x86_64-linux-gnu/lua/5.1/cjson.so /usr/local/lib/lua/5.1/cjson.so && \
  wget -O /usr/local/lib/lua/5.1/rx.lua -x https://raw.githubusercontent.com/bjornbytes/RxLua/master/rx.lua && \
  cd /root/ && \
  git clone https://github.com/vschiavoni/luacsv.git && \
  cd luacsv/ && \
  gcc -fPIC -I/usr/include/lua5.1/ -shared -O3 csv.c -o csv.so && \
  cp csv.so /usr/local/lib/lua/5.1/ && \
  rm -rf /root/luacsv/ && \
  apt-get -y remove --auto-remove git gcc g++ make cmake liblua5.1-0-dev wget chrpath && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD build_files/zmq-rx.lua /usr/local/lib/lua/5.1/
RUN mkdir /root/worker

WORKDIR /root/worker
ENTRYPOINT ["lua"]
