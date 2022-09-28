FROM alpine:3.16.2 AS builder

RUN apk add --no-cache \
        build-base \
        cmake \
        libpng-dev \
        jpeg-dev \
        libxi-dev \
        mesa-dev \
        sqlite-dev \
        libogg-dev \
        libvorbis-dev \
        openal-soft-dev \
        curl-dev \
        freetype-dev \
        zlib-dev \
        gmp-dev \
        jsoncpp-dev \
        luajit-dev \
        zstd-dev \
        ncurses-dev \
        ibpq-dev

RUN wget https://github.com/minetest/minetest/archive/5.6.1.tar.gz && \
        tar xf 5.6.1.tar.gz && \
        cd minetest-5.6.1/games && \
        wget https://github.com/minetest/minetest_game/archive/master.tar.gz && \
        tar xf master.tar.gz && \
        mv minetest_game-master minetest_game && \
        cd .. && \
        cd lib/ && \
        wget https://github.com/minetest/irrlicht/archive/master.tar.gz && \
        tar xf master.tar.gz && \
        mv irrlicht-master irrlichtmt && \
        cd ..

RUN cmake -B build \
        -DRUN_IN_PLACE=TRUE \
        -DBUILD_CLIENT=FALSE \
        -DBUILD_SERVER=TRUE \
        -DBUILD_UNITTESTS=FALSE \
        -DENABLE_CURSES=ON \
        -DENABLE_POSTGRESQL=ON && \
    cmake --build build && \
    cmake --install build

FROM alpine:3.16.2 AS runtime

RUN apk add --no-cache \
        sqlite-libs \
        curl \
        gmp \
        libstdc++ \
        libgcc \
        libpq \
        luajit \
        ncurses \
        jsoncpp \
        zstd-libs && \
    adduser -D minetest --uid 30000 -h /minetest-5.6.1 && \
	chown -R minetest:minetest /minetest-5.6.1

WORKDIR /minetest-5.6.1

USER minetest:minetest

EXPOSE 30000/udp

CMD ["./bin/minetestserver", "--config", "./conf/minetest.conf", "--terminal"]
