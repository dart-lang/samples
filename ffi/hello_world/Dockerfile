FROM google/dart:2.6-dev

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
COPY . /app
RUN pub get --offline

RUN apt-get update && apt-get install -y make gcc

CMD []
ENTRYPOINT ["pub", "run", "test"]
