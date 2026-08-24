# Cloud Run server sample

A minimal, production-ready HTTP service designed for deployment to
[Google Cloud Run](https://cloud.google.com/run) using
[`package:google_cloud`](https://pub.dev/packages/google_cloud) and
[`package:google_cloud_shelf`](https://pub.dev/packages/google_cloud_shelf).

## Features

- **Structured cloud logging**:
  Automatically outputs GCP-compliant JSON log payloads correlated with
  incoming `X-Cloud-Trace-Context` headers on Cloud Run,
  falling back to human-readable console logs when running locally.
- **Signal-driven graceful shutdown**:
  Automatically captures `SIGTERM` and `SIGINT` signals with `serveHandler` to
  finish pending requests before container termination.
- **Port detection**:
  Respects the `PORT` environment variable injected by Cloud Run.
- **Minimal container image**:
  Multi-stage Dockerfile compiling Dart to a
  native AOT binary on top of a `scratch` base image.

## Run locally

Run the server with the Dart CLI:

```sh
dart run bin/server.dart
```

In another terminal, test the endpoints:

```sh
curl http://localhost:8080/
curl http://localhost:8080/healthz
curl http://localhost:8080/time
```

## Run tests

```sh
dart test
```

## Deploy to Cloud Run

### Fast direct source deployment (osonly)

From the repository root:

```sh
dart run tool/deploy_server.dart server/cloud_run
```

### Standard container deployment (Docker)

Deploy the container to Cloud Run using
the [gcloud CLI](https://docs.cloud.google.com/sdk/gcloud):

```sh
gcloud run deploy dart-cloud-run-sample \
  --source . \
  --region us-central1 \
  --allow-unauthenticated
```
