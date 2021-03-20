A simple Dart HTTP server using [package:shelf](https://pub.dev/packages/shelf).

- Listens on "any IP" (0.0.0.0) instead of loop-back (localhost, 127.0.0.1) to
  allow remote connections.
- Defaults to listening on port `8080`, but this can be configured by setting
  the `PORT` environment variable.
- Includes `Dockerfile` for easy containerization
- Follow instructions at
  https://cloud.google.com/run/docs/quickstarts/build-and-deploy to build and
  deploy on [Google Cloud Run](https://cloud.google.com/run).
