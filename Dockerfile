FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

RUN useradd -m -d /home/container -s /bin/bash container

RUN ln -s /home/container/ /nonexistent

ENV USER=container HOME=/home/container

RUN apt-get update; \
    apt-get install -y --no-install-recommends gcc g++ libgcc1 lib32gcc-s1 libc++-dev gdb libc6 git wget curl tar zip unzip binutils xz-utils liblzo2-2 cabextract iproute2 net-tools netcat-traditional telnet libatomic1 libsdl1.2debian libsdl2-2.0-0 \
    libfontconfig icu-devtools libunwind8 libssl-dev sqlite3 libsqlite3-dev libmariadb-dev locales ffmpeg gnupg2 apt-transport-https software-properties-common ca-certificates tzdata \
    liblua5.4 libz-dev rapidjson-dev jq locales; \
    update-locale lang=en_US.UTF-8; \
    dpkg-reconfigure --frontend noninteractive locales; \
    apt-get purge -y --auto-remove; apt-get clean; rm -rf /var/lib/apt/lists/*

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
