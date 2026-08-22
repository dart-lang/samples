# Google Cloud Storage Server Sample

An HTTP service demonstrating how to interact with
[Google Cloud Storage](https://cloud.google.com/storage) using
[package:google_cloud_storage](https://pub.dev/packages/google_cloud_storage),
[package:google_cloud_shelf](https://pub.dev/packages/google_cloud_shelf), and
[package:google_cloud](https://pub.dev/packages/google_cloud).

## Features

- **Object Storage Operations**: List bucket contents, download files, and upload
  objects with custom MIME types using idiomatic Dart APIs.
- **Application Default Credentials (ADC)**: Authenticates automatically using
  attached Cloud Run service accounts in production, or `gcloud auth application-default login`
  in local development.
- **Structured Cloud Logging**: Seamless JSON logging and trace correlation.
- **Graceful Lifecycle Management**: Clean SIGTERM/SIGINT signal handling.

## Running Locally

1. Authenticate with Google Cloud locally:
   ```sh
   gcloud auth application-default login
   ```
2. Set your Cloud Storage bucket name:
   ```sh
   export STORAGE_BUCKET="my-demo-bucket"
   ```
3. Start the server:
   ```sh
   dart run bin/server.dart
   ```
4. Test endpoints:
   ```sh
   # View API info
   curl http://localhost:8080/

   # List objects in bucket
   curl http://localhost:8080/files

   # Upload a text file
   curl -X POST http://localhost:8080/files/hello.txt \
     -H "Content-Type: text/plain" \
     -d "Hello, Cloud Storage!"

   # Download the file
   curl http://localhost:8080/files/hello.txt
   ```

## Running Tests

```sh
dart test
```

## Deploying to Cloud Run

### Fast Direct Source Deployment (osonly)

From the repository root:

```sh
dart tool/deploy_server.dart server/cloud_storage --set-env-vars=STORAGE_BUCKET="my-demo-bucket"
```

### Standard Container Deployment (Docker)

```sh
gcloud run deploy dart-storage-sample \
  --source . \
  --region us-central1 \
  --set-env-vars STORAGE_BUCKET="my-demo-bucket" \
  --allow-unauthenticated
```
