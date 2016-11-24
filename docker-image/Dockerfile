FROM ubuntu:16.04
MAINTAINER aurelien.havet@unine.ch
ENV PACKAGES git gcc g++ make cmake liblua5.3-dev wget
WORKDIR /root

RUN apt-get update && \
  apt-get install -y $PACKAGES lua5.3 liblua5.3-0 libzmq5-dev && \
  git clone https://github.com/Lorel/lzmq.git && \
  cd lzmq && \
  mkdir cmake-make && \
  cd cmake-make && \
  cmake .. && \
  make install && \
  mkdir -p /usr/local/lib/lua/5.3/ && \
  mv /usr/local/lib/lua/lzmq /usr/local/lib/lua/5.3/lzmq && \
  mv /usr/local/lib/lua/lzmq.so /usr/local/lib/lua/5.3/lzmq.so && \
  rm -rf /root/lzmq/ && \
  cd /root && \
  git clone https://github.com/mpx/lua-cjson.git && \
  cd lua-cjson && \
  make install LUA_INCLUDE_DIR=/usr/include/lua5.3 && \
  rm -rf /root/lua-cjson && \
  cd /root/ && \
  git clone https://github.com/Lorel/luacsv.git && \
  cd luacsv/ && \
  gcc -fPIC -I/usr/include/lua5.3/ -shared -O3 csv.c -o csv.so && \
  cp csv.so /usr/local/lib/lua/5.3/ && \
  rm -rf /root/luacsv/ && \
  wget -O /usr/local/lib/lua/5.3/rx.lua https://raw.githubusercontent.com/bjornbytes/RxLua/master/rx.lua && \
  wget -O /usr/local/lib/lua/5.3/log.lua https://raw.githubusercontent.com/Lorel/log.lua/master/log.lua && \
  apt-get -y remove --auto-remove $PACKAGES && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s /usr/bin/lua5.3 /usr/bin/lua

ADD build_files/zmq-rx.lua /usr/local/lib/lua/5.3/
RUN mkdir /root/worker

WORKDIR /root/worker
ENTRYPOINT ["lua"]
