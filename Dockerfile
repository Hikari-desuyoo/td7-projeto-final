FROM ruby:2.7.0

ENV NODE_VERSION 16
ENV INSTALL_PATH /td7-projeto-final

RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
RUN apt-get update

RUN apt-get install -y nodejs
RUN npm install -g yarn

WORKDIR ${INSTALL_PATH}

COPY Gemfile .
COPY Gemfile.lock .
RUN bundler install

COPY . .
