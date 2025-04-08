FROM debian:12-slim

RUN apt update \
    && apt install -y \
        unzip \
        wget \
        locales \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources \
    && sed -i -e's/ main/ main contrib/g' /etc/apt/sources.list.d/debian.sources \
    && apt update \
    && apt install -y --install-recommends winehq-stable \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt update \
    && apt install -y winetricks xvfb \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ADD https://github.com/futrime/lip/releases/latest/download/lip-cli-win-x64-self-contained.zip lip.zip

RUN unzip lip.zip -d /opt/lip/ \
    && rm lip.zip

COPY --chmod=755 lip /usr/local/bin/lip

COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

WORKDIR /data

ENTRYPOINT ["entrypoint.sh"]
