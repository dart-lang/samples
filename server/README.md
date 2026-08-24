# Server samples

Examples demonstrating how to build, test, and deploy HTTP services in Dart using
[package:shelf](https://pub.dev/packages/shelf) and official
[Google Cloud](https://cloud.google.com) packages.

## Available samples

1. **[`simple/`](simple/)**:
   A baseline, vendor-neutral Dart HTTP server. Demonstrates route handling,
   cascading static file serving, and standard Docker containerization without
   cloud dependencies.
2. **[`cloud_run/`](cloud_run/)**:
   A production-ready [Google Cloud Run](https://cloud.google.com/run) service.
   Demonstrates structured JSON logging correlated with `X-Cloud-Trace-Context`,
   port detection, and signal-driven graceful shutdown using
   [`package:google_cloud_shelf`](https://pub.dev/packages/google_cloud_shelf)
   and [`package:google_cloud`](https://pub.dev/packages/google_cloud).
3. **[`cloud_storage/`](cloud_storage/)**:
   An HTTP service integrating with
   [Google Cloud Storage](https://cloud.google.com/storage) using
   [`package:google_cloud_storage`](https://pub.dev/packages/google_cloud_storage)
   and [`package:google_cloud_shelf`](https://pub.dev/packages/google_cloud_shelf).
   Demonstrates bucket listing, file upload/download, and Application Default
   Credentials.

## Deploy to Cloud Run

Each sample can be deployed to [Cloud Run](https://cloud.google.com/run) using
either of two methods:

### Fast direct source deployment

Use the shared [`tool/deploy_server.dart`](../tool/deploy_server.dart) script to
compile the Dart server to a native Linux AOT binary locally and
deploy directly with Cloud Run's `osonly24` base image:

```sh
# Deploy any sample from the repository root (~15-20 seconds):
dart run tool/deploy_server.dart server/simple
dart run tool/deploy_server.dart server/cloud_run
dart run tool/deploy_server.dart server/cloud_storage --set-env-vars=STORAGE_BUCKET=my-bucket
```

### Standard container deployment

Deploy the container to Cloud Run using
the [gcloud CLI](https://docs.cloud.google.com/sdk/gcloud):

```sh
cd server/cloud_run
gcloud run deploy dart-cloud-run-sample \
  --source . \
  --region us-central1 \
  --allow-unauthenticated
```
