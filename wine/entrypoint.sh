#! /usr/bin/env sh

VERSION="${VERSION:-LATEST}"

if [ "$EULA" != "TRUE" ]
then
    echo "You must accept the Minecraft EULA to run the server"
    echo "Set the environment variable EULA to TRUE to accept it"
    exit 1
fi

if [ ! -d "/root/.wine" ]
then
    LC_ALL="C.UTF8" winecfg
    xvfb-run -a winetricks -q cjkfonts vcrun2022 riched20
fi

export WINEDEBUG="${WINEDEBUG:--all}"

if [ ! -f "bedrock_server_mod.exe" ]
then
    if [ "$GITHUB_MIRROR_URL" != "" ]
    then
        lip config set github_proxies=$GITHUB_MIRROR_URL
    fi

    if [ "$GO_MODULE_PROXY_URL" != "" ]
    then
        lip config set go_module_proxies=$GO_MODULE_PROXY_URL
    fi

    if [ "$VERSION" = "LATEST" ]
    then
        lip install github.com/LiteLDev/LeviLamina
    else
        lip install github.com/LiteLDev/LeviLamina@$VERSION
    fi

    for package in $PACKAGES
    do
        lip install $package
    done
fi

LC_ALL="C.UTF8" wine64 bedrock_server_mod.exe
