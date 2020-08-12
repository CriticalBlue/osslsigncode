FROM ubuntu:18.04

# == Install required tools
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install -qq -y \
  curl \
  expect \
  git \
  nano \
  python \
  python-dev \
  python-pip \
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

RUN git clone https://github.com/mtrojnar/osslsigncode.git && cd osslsigncode/

# == Build osslsigncode
RUN ./autogen.sh && ./configure && make && make install
RUN cd .. && rm -fr osslsigncode/



