FROM google/dart:2.7

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
COPY . /app
RUN pub get --offline

RUN apt-get update && apt-get install -y make gcc cmake

RUN (cd hello_library && cmake . && make)

CMD dart hello.dart
