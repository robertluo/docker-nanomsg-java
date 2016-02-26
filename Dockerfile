FROM java:8 
ENV NANOMSG_VERSION=0.8-beta
ENV BUILD_PACKAGES="build-essential"
WORKDIR /tmp
RUN \
    apt-get update && apt-get install -y $BUILD_PACKAGES; \
    curl -L0k https://github.com/nanomsg/nanomsg/releases/download/$NANOMSG_VERSION/nanomsg-$NANOMSG_VERSION.tar.gz | tar xz; \
    cd nanomsg-$NANOMSG_VERSION; \
    ./configure; \
    make && make check && make install; \
    echo /usr/local/lib > /etc/ld.so.conf.d/usr-local.conf; \
    ldconfig; \
    cd ..; \
    rm -rf *; \
    apt-get purge -y $BUILD_PACKAGES $(apt-mark showauto) && rm -rf /var/lib/apt/lists/*; 
