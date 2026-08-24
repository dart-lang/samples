![Welcome Dart Server](public/welcome_dart_server.png)

A simple Dart HTTP server using [package:shelf](https://pub.dev/packages/shelf).

- Listens on "any IP" (0.0.0.0) instead of loop-back (localhost, 127.0.0.1) to
  allow remote connections.
- Defaults to listening on port `8080`, but this can be configured by setting
  the `PORT` environment variable. (This is also the convention used by
  [Cloud Run](https://cloud.google.com/run).)
- Includes a `Dockerfile` for easy containerization.

## Run locally

```bash
dart run bin/server.dart
```

## Run tests

```bash
dart test
```

## Deploy to Google Cloud Run

### Fast direct source deployment (osonly)

From the repository root, deploy using the shared deployment tool:

```bash
dart run tool/deploy_server.dart server/simple
```

Or from within this directory:

```bash
dart run ../../tool/deploy_server.dart
```

### Standard container deployment (Docker)

Deploy using the included multi-stage `Dockerfile` with
the [gcloud CLI](https://docs.cloud.google.com/sdk/gcloud):

```bash
gcloud run deploy dart-sample-simple \
  --source . \
  --region us-central1 \
  --allow-unauthenticated
```
