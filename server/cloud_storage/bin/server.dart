// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:google_cloud/google_cloud.dart';
import 'package:google_cloud_shelf/google_cloud_shelf.dart';
import 'package:google_cloud_storage/google_cloud_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  String? projectId;
  try {
    projectId = await computeProjectId();
    print('Running on Google Cloud Project: $projectId');
  } on MetadataServerException {
    print('Running locally (standard console logging)');
  }

  // Storage client automatically authenticates with Application Default
  // Credentials (ADC) on Cloud Run, Compute Engine, or via local `gcloud auth`.
  // When running in local/CI environments without credentials, pass an unauthenticated
  // http.Client to prevent metadata server resolution errors.
  final storage = Storage(
    projectId: projectId,
    client: projectId == null ? http.Client() : null,
  );

  final bucketName = Platform.environment['STORAGE_BUCKET'];

  final router = Router()
    ..get('/', (Request request) => _rootHandler(request, bucketName))
    ..get(
      '/files',
      (Request request) => _listFilesHandler(request, storage, bucketName),
    )
    ..get(
      '/files/<name>',
      (Request request, String name) =>
          _downloadFileHandler(request, storage, bucketName, name),
    )
    ..post(
      '/files/<name>',
      (Request request, String name) =>
          _uploadFileHandler(request, storage, bucketName, name),
    );

  final handler = Pipeline()
      .addMiddleware(createLoggingMiddleware(projectId: projectId))
      .addHandler(router.call);

  await serveHandler(handler);
}

Response _rootHandler(Request request, String? bucketName) => Response.ok(
  jsonEncode({
    'service': 'Google Cloud Storage Dart Demo',
    'bucketConfigured': bucketName != null && bucketName.isNotEmpty,
    'bucketName': bucketName ?? '<not configured, set STORAGE_BUCKET env var>',
    'endpoints': {
      'GET /files': 'List all files in the bucket',
      'GET /files/<name>': 'Download a specific file',
      'POST /files/<name>': 'Upload binary or text payload to <name>',
    },
  }),
  headers: {'content-type': 'application/json'},
);

Future<Response> _listFilesHandler(
  Request request,
  Storage storage,
  String? bucketName,
) async {
  if (bucketName == null || bucketName.isEmpty) {
    return Response.badRequest(
      body: jsonEncode({
        'error': 'STORAGE_BUCKET environment variable is not set.',
      }),
      headers: {'content-type': 'application/json'},
    );
  }

  final files = <Map<String, Object?>>[];
  await for (final item in storage.listObjects(bucketName)) {
    files.add({
      'name': item.name,
      'size': item.size?.toString(),
      'contentType': item.contentType,
      'updated': item.updated?.toJson(),
    });
  }

  return Response.ok(
    jsonEncode({'bucket': bucketName, 'files': files}),
    headers: {'content-type': 'application/json'},
  );
}

Future<Response> _downloadFileHandler(
  Request request,
  Storage storage,
  String? bucketName,
  String name,
) async {
  if (bucketName == null || bucketName.isEmpty) {
    return Response.badRequest(
      body: jsonEncode({
        'error': 'STORAGE_BUCKET environment variable is not set.',
      }),
      headers: {'content-type': 'application/json'},
    );
  }

  try {
    final bucket = storage.bucket(bucketName);
    final object = bucket.object(name);
    final metadata = await object.metadata();
    final bytes = await object.download();

    return Response.ok(
      bytes,
      headers: {
        'content-type': metadata.contentType ?? 'application/octet-stream',
        'content-length': bytes.length.toString(),
      },
    );
  } on NotFoundException {
    return Response.notFound(
      jsonEncode({
        'error': 'File "$name" was not found in bucket "$bucketName".',
      }),
      headers: {'content-type': 'application/json'},
    );
  }
}

Future<Response> _uploadFileHandler(
  Request request,
  Storage storage,
  String? bucketName,
  String name,
) async {
  if (bucketName == null || bucketName.isEmpty) {
    return Response.badRequest(
      body: jsonEncode({
        'error': 'STORAGE_BUCKET environment variable is not set.',
      }),
      headers: {'content-type': 'application/json'},
    );
  }

  final bytes = await request.read().expand((chunk) => chunk).toList();
  final contentType = request.headers['content-type'] ?? 'text/plain';

  final bucket = storage.bucket(bucketName);
  final object = bucket.object(name);
  final metadata = await object.upload(
    bytes,
    metadata: ObjectMetadata(name: name, contentType: contentType),
  );

  return Response.ok(
    jsonEncode({
      'message': 'Uploaded "$name" successfully',
      'size': metadata.size?.toString(),
      'contentType': metadata.contentType,
      'updated': metadata.updated?.toJson(),
    }),
    headers: {'content-type': 'application/json'},
  );
}
