FROM fedora:34
MAINTAINER codefossa (codefossa@gmail.com)

COPY ./template /app/server/server
COPY ./start.sh /

RUN mkdir -p /app/tmp
WORKDIR /app/tmp

RUN curl https://raw.githubusercontent.com/rpmsphere/noarch/master/r/rpmsphere-release-34-1.noarch.rpm -o rpmsphere.rpm
RUN dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
  rpmsphere.rpm

RUN dnf upgrade -y && dnf install -y \
  which \
  findutils \
  bzr \
  automake \
  bison \
  g++ \
  libxml2-devel \
  boost-devel \
  protobuf-devel \
  mesa-libGLU-devel \
  zthread-devel \
  php \
  php-json \
  php-mysqlnd \
  php-sqlite3 \
  php-xml \
  php-bcmath \
  php-curl

RUN bzr branch lp:~armagetronad-ap/armagetronad/0.2.9-armagetronad-sty+ct+ap /app/tmp/src

WORKDIR /app/tmp/src
RUN ./bootstrap.sh
RUN ./configure --prefix=/app/server --disable-glout --enable-authentication --with-zthread --disable-sysinstall --disable-useradd --disable-etc --disable-desktop --disable-uninstall
RUN make
RUN make install

WORKDIR /

RUN chmod 755 /app/server/bin
RUN rm -R /app/tmp

ENTRYPOINT ["/start.sh"]
