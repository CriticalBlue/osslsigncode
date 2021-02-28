FROM ubuntu:20.04

# == Install required tools
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -qq -y \
  curl \
  expect \
  git \
  nano \
  python \
  python-dev \
  python3-pip \
  scons \
  unzip \
  wget \
  zip \
  tzdata \
  openssl \
  libcurl4-openssl-dev \
  libssl-dev \
  libengine-pkcs11-openssl \
  curl \
  libcurl4 \
  git \
  automake \
  libtool \
  pkg-config \
  wget \
  libccid \
  libpcsclite1 \
  pcscd \
  usbutils \
  opensc

RUN ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime

RUN git clone https://github.com/mtrojnar/osslsigncode.git

# == Build osslsigncode
RUN cd osslsigncode/ && ./autogen.sh && ./configure && make && make install
RUN cd .. && rm -fr osslsigncode/

# == Install go 1.16
## Golang

ENV GOLANG_VERSION 1.16
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 013a489ebb3e24ef3d915abe5b94c3286c070dfe0818d5bca8108f1d6e8440d2

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
  && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz

RUN mkdir /go
# Setup Go Environment Variables
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

