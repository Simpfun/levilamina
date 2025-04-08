FROM ghcr.io/liteldev/levilamina-server:latest-wine

RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen en_US.UTF-8 zh_CN.UTF-8

ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
