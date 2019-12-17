FROM google/dart:2.7

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
COPY . /app
RUN pub get --offline

RUN apt-get update && apt-get install -y make gcc cmake

CMD pub run test
