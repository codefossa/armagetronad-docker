FROM fedora:38
MAINTAINER codefossa (codefossa@gmail.com)

ENV UID=0
ENV GID=0

COPY ./ZThread-2.3.2 /app/tmp/zthread
COPY ./template /app/server/server
COPY ./start.sh /

RUN dnf install -y \
  which \
  findutils \
  git \
  automake \
  bison \
  g++ \
  libxml2-devel \
  boost-devel \
  protobuf-devel \
  mesa-libGLU-devel \
  php \
  php-json \
  php-mysqlnd \
  php-sqlite3 \
  php-xml \
  php-bcmath \
  php-curl

RUN mkdir -p /app/tmp
RUN git clone --depth 1 -b hack-0.2.8-sty+ct+ap https://github.com/ArmagetronAd/armagetronad.git /app/tmp/src

WORKDIR /app/tmp/zthread
RUN ./configure CXXFLAGS="-fpermissive" --prefix=/usr/
RUN make
RUN make install
RUN ldconfig

WORKDIR /app/tmp/src
RUN ./bootstrap.sh
RUN ./configure --prefix=/app/server --disable-glout --enable-authentication --with-zthread --disable-sysinstall --disable-useradd --disable-etc --disable-desktop --disable-uninstall
RUN make
RUN make install

WORKDIR /

RUN chmod 755 /app/server/bin
RUN rm -R /app/tmp

ENTRYPOINT ["/start.sh"]
