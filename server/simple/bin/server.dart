// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

Future main() async {
  // Find port to listen on from environment variable.
  // https://cloud.google.com/run/docs/reference/container-contract#port
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  // Serve static files from a file system directory.
  final _staticHandler =
      createStaticHandler('public', defaultDocument: 'index.html');

  // Cascade helps in chaining multiple handlers together.
  final _cascade = Cascade().add(_staticHandler).add(_router);

  // Serve handler on given port.
  final server = await serve(
    _cascade.handler,
    InternetAddress.anyIPv4, // Allows external connections
    port,
  );

  print('Serving at http://${server.address.host}:${server.port}');
}

// Router instance to handler requests.
final _router = Router()
  ..get('/helloworld', _helloWorldHandler)
  ..get('/time',
      (request) => Response.ok(DateTime.now().toUtc().toIso8601String()));

Response _helloWorldHandler(Request request) => Response.ok('Hello, World!');
