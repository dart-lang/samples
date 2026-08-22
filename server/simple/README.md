![Welcome Dart Server](public/welcome_dart_server.png)

A simple Dart HTTP server using [package:shelf](https://pub.dev/packages/shelf).

- Listens on "any IP" (0.0.0.0) instead of loop-back (localhost, 127.0.0.1) to
  allow remote connections.
- Defaults to listening on port `8080`, but this can be configured by setting
  the `PORT` environment variable. (This is also the convention used by
  [Cloud Run](https://cloud.google.com/run).)
- Includes `Dockerfile` for easy containerization.

## Running Locally

```bash
dart run bin/server.dart
```

## Running Tests

```bash
dart test
```

## Deploying to Google Cloud Run

### Fast Direct Source Deployment (osonly)

From the repository root, deploy using the shared deployment tool:

```bash
dart tool/deploy_server.dart server/simple
```

Or from within this directory:

```bash
dart ../../tool/deploy_server.dart
```

### Standard Container Deployment (Docker)

Deploy using the included multi-stage `Dockerfile`:

```bash
gcloud run deploy dart-sample-simple \
  --source . \
  --region us-central1 \
  --allow-unauthenticated
```
