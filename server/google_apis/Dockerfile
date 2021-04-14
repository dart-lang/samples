# Use Google's official Dart image.
# https://hub.docker.com/r/google/dart
FROM google/dart

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
ADD . /app/
RUN pub get --offline

CMD []
ENTRYPOINT ["/usr/bin/dart", "bin/server.dart"]
