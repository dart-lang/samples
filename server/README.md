# Server Samples

Examples demonstrating how to build, test, and deploy HTTP services in Dart using
[package:shelf](https://pub.dev/packages/shelf) and official
[Google Cloud](https://cloud.google.com) packages.

## Available Samples

1. **[`simple/`](simple/)**:
   A baseline, vendor-neutral Dart HTTP server. Demonstrates route handling, cascading
   static file serving, and standard Docker containerization without cloud dependencies.
2. **[`cloud_run/`](cloud_run/)**:
   A production-ready [Google Cloud Run](https://cloud.google.com/run) service.
   Demonstrates structured JSON logging correlated with `X-Cloud-Trace-Context`,
   port detection, and signal-driven graceful shutdown using
   [`package:google_cloud_shelf`](https://pub.dev/packages/google_cloud_shelf) and
   [`package:google_cloud`](https://pub.dev/packages/google_cloud).
3. **[`cloud_storage/`](cloud_storage/)**:
   An HTTP service integrating with [Google Cloud Storage](https://cloud.google.com/storage)
   using [`package:google_cloud_storage`](https://pub.dev/packages/google_cloud_storage)
   and [`package:google_cloud_shelf`](https://pub.dev/packages/google_cloud_shelf).
   Demonstrates bucket listing, file upload/download, and Application Default Credentials.

## Deploying to Cloud Run

Each sample can be deployed to Cloud Run using either of two methods:

### Method 1: Fast Direct Source Deployment (Recommended)

Use the shared [`tool/deploy_server.dart`](../tool/deploy_server.dart) script to compile
the Dart server to a native Linux AOT binary locally and deploy directly via Cloud Run's
`osonly24` base image:

```sh
# Deploy any sample from the repository root (~15-20 seconds):
dart tool/deploy_server.dart server/simple
dart tool/deploy_server.dart server/cloud_run
dart tool/deploy_server.dart server/cloud_storage --set-env-vars=STORAGE_BUCKET=my-bucket
```

### Method 2: Standard Docker Container Deployment

Each sample includes a multi-stage `Dockerfile` that compiles to a minimal `scratch` image:

```sh
cd server/cloud_run
gcloud run deploy dart-cloud-run-sample --source . --region us-central1 --allow-unauthenticated
```
