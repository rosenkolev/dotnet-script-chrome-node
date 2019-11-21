FROM mcr.microsoft.com/dotnet/core/sdk:3.0-alpine

# Install dotnet-script
RUN dotnet tool install dotnet-script --tool-path /usr/bin

# Installs latest Chromium package.
RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && apk add --no-cache \
    chromium@edge \
    harfbuzz@edge \
    nss@edge \
    freetype@edge \
    ttf-freefont@edge \
    && rm -rf /var/cache/* \
    && mkdir /var/cache/apk

# Install nodejs
RUN apk add --no-cache tini@edge make@edge gcc@edge g++@edge python@edge git@edge nodejs@edge nodejs-npm@edge yarn@edge libuv@edge \
    && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing wqy-zenhei \
	&& rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

RUN mkdir -p /app
WORKDIR /app

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

ENTRYPOINT ["tini", "--", "sh"]