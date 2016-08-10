FROM alpine:3.4
RUN apk update && apk add git make build-base openssl curl file autoconf automake libtool
RUN git clone http://luajit.org/git/luajit-2.0.git && \
  cd luajit-2.0 && \
  git checkout v2.1 && \
  make && \
  make install && \
  ln -sf luajit-2.1.0-beta2 /usr/local/bin/luajit && \
  ln -sf luajit /usr/local/bin/lua
RUN curl -sSL https://github.com/keplerproject/luarocks/archive/v2.3.0.tar.gz | gunzip | tar xf - && \
  cd luarocks-2.3.0 && \
  ./configure --lua-suffix=jit-2.1.0-beta2 --with-lua=/usr/local --with-lua-include=/usr/local/include/luajit-2.1 && \
  make && \
  make install
