Additional samples for [Concurrency in Dart][concurrency-in-dart].

- `bin/send_and_receive.dart`: Demonstrates how to spawn an [`Isolate`][] and
  send it initial input using `Isolate.spawn`. The spawned isolate is shortlived
  and returns its result to the main isolate using [`Isolate.exit`][], which is
  fast.
- `bin/long_running_isolate.dart`: Similar to `send_and_receive.dart`, except
  that the spawned isolate is long running, responds to incoming messages from
  the main isolate, and sends responses until it receives a `null` over its
  [`SendPort`][].

[concurrency-in-dart]: https://dart.dev/guides/language/concurrency
[`Isolate`]: https://api.dart.dev/stable/dart-isolate/Isolate-class.html
[`Isolate.exit`]: https://api.dart.dev/stable/2.15.0/dart-isolate/Isolate/exit.html
[`SendPort`]: https://api.dart.dev/stable/dart-isolate/SendPort-class.html
