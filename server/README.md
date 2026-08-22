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

Each sample includes a `Dockerfile` for turnkey deployment to Cloud Run or any container host.
See the `README.md` in each directory for detailed setup and deployment instructions.
