Additional samples for [Concurrency in Dart][concurrency-in-dart].

- `bin/send_and_receive.dart`: Demonstrates how to spawn a 
  worker [`Isolate`][] with [`Isolate.run`][]. 
  `Isolate.run` executes the specified function and returns the result
  to the main isolate efficiently using [`Isolate.exit`][] which avoids copying.
- `bin/long_running_isolate.dart`: Similar to `send_and_receive.dart`, except
  that the spawned isolate is long running, responds to incoming messages from
  the main isolate, and sends responses until it receives a `null` over its
  [`SendPort`][].

[concurrency-in-dart]: https://dart.dev/guides/language/concurrency
[`Isolate`]: https://api.dart.dev/stable/dart-isolate/Isolate-class.html
[`Isolate.run`]: https://api.dart.dev/stable/dart-isolate/Isolate/run.html
[`Isolate.exit`]: https://api.dart.dev/stable/dart-isolate/Isolate/exit.html
[`SendPort`]: https://api.dart.dev/stable/dart-isolate/SendPort-class.html
