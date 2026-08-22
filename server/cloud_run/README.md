# Cloud Run Server Sample

A minimal, production-ready HTTP service designed for deployment to
[Google Cloud Run](https://cloud.google.com/run) using
[package:google_cloud](https://pub.dev/packages/google_cloud) and
[package:google_cloud_shelf](https://pub.dev/packages/google_cloud_shelf).

## Features

- **Structured Cloud Logging**: Automatically outputs GCP-compliant JSON log
  payloads correlated with incoming `X-Cloud-Trace-Context` headers on Cloud Run,
  falling back to human-readable console logs when running locally.
- **Signal-Driven Graceful Shutdown**: Automatically captures `SIGTERM` and `SIGINT`
  signals via `serveHandler` to finish pending requests before container termination.
- **Port Detection**: Respects the `PORT` environment variable injected by Cloud Run.
- **Minimal Container Image**: Multi-stage Dockerfile compiling Dart to a native AOT
  binary on top of a `scratch` base image.

## Running Locally

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

## Running Tests

```sh
dart test
```

## Deploying to Cloud Run

### Fast Direct Source Deployment (osonly)

From the repository root:

```sh
dart tool/deploy_server.dart server/cloud_run
```

### Standard Container Deployment (Docker)

```sh
gcloud run deploy dart-cloud-run-sample \
  --source . \
  --region us-central1 \
  --allow-unauthenticated
```
