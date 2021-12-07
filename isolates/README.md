Additional samples for [Concurrency in Dart][concurrency-in-dart].

- `bin/send_and_receive.dart`: Demonstrates how to spawn an [`Isolate`][] and
  communicate with it using a [`SendPort`][]. The spawned isolate first sends a
  SendPort for the main isolate to communicate with.
- `bin/long_running_isolate.dart`: Similar to `send_and_receive.dart`, except
  that the spawned isolate responds to incoming messages from the main isolate,
  sending a response until `null` is sent over the [`SendPort`][].

[concurrency-in-dart]: https://dart.dev/guides/language/concurrency
[`Isolate`]: https://api.dart.dev/stable/dart-isolate/Isolate-class.html
[`SendPort`]: https://api.dart.dev/stable/dart-isolate/SendPort-class.html
