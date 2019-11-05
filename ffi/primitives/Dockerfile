FROM google/dart:2.6.0-dev.8.2

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
COPY . /app
RUN pub get --offline

RUN apt-get update && apt-get install -y make gcc
