// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:google_cloud/google_cloud.dart';
import 'package:google_cloud_shelf/google_cloud_shelf.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  // Determine Google Cloud project ID from the environment or metadata server
  // if running on Cloud Run.
  String? projectId;
  try {
    projectId = await computeProjectId();
    print('Running on Google Cloud Project: $projectId');
  } on MetadataServerException {
    print('Running locally (standard console logging)');
  }

  final router = Router()
    ..get('/', _rootHandler)
    ..get('/time', _timeHandler)
    ..get('/healthz', _healthHandler);

  // createLoggingMiddleware() automatically formats structured JSON logs
  // correlated with Google Cloud Trace on Cloud Run (when projectId is present),
  // and falls back to standard Shelf request logging when running locally.
  final handler = Pipeline()
      .addMiddleware(createLoggingMiddleware(projectId: projectId))
      .addHandler(router.call);

  // serveHandler() automatically binds to the PORT environment variable
  // (default: 8080) and handles SIGINT / SIGTERM signals for graceful shutdown.
  await serveHandler(handler);
}

Response _rootHandler(Request request) => Response.ok(
  jsonEncode({'message': 'Hello from Cloud Run with Dart!'}),
  headers: {'content-type': 'application/json'},
);

Response _timeHandler(Request request) => Response.ok(
  jsonEncode({'utc': DateTime.now().toUtc().toIso8601String()}),
  headers: {'content-type': 'application/json'},
);

Response _healthHandler(Request request) => Response.ok(
  jsonEncode({'status': 'healthy'}),
  headers: {'content-type': 'application/json'},
);
