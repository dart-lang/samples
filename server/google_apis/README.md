A Dart HTTP service meant to be deployed to
[Cloud Run](https://cloud.google.com/run) and which uses the
[Cloud Firestore](https://firebase.google.com/products/firestore) features in
[package:googleapis](https://pub.dev/packages/googleapis).

- Increments a counter stored in Cloud Firestore via a transaction.
- Based on [package:shelf](https://pub.dev/packages/shelf).
- Includes a number of useful APIs in `lib/helpers.dart` which can be copied and
  used in other projects.
- Follow instructions at
  https://cloud.google.com/run/docs/quickstarts/build-and-deploy to build and
  deploy on [Cloud Run](https://cloud.google.com/run).
- To deploy this demo, you will also need to enable the
  [Cloud Firestore API](https://console.cloud.google.com/apis/api/firestore.googleapis.com).
