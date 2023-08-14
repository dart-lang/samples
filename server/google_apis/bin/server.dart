// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:google_cloud/google_cloud.dart';
import 'package:googleapis/firestore/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Future main() async {
  final projectId = await computeProjectId();
  print('Current GCP project id: $projectId');

  final authClient = await clientViaApplicationDefaultCredentials(
    scopes: [FirestoreApi.datastoreScope],
  );

  try {
    final api = FirestoreApi(authClient);

    Future<Response> incrementHandler(Request request) async {
      final result = await api.projects.databases.documents.commit(
        _incrementRequest(projectId),
        'projects/$projectId/databases/(default)',
      );

      return Response.ok(
        JsonUtf8Encoder(' ').convert(result),
        headers: {
          'content-type': 'application/json',
        },
      );
    }

    final router = Router()..get('/', incrementHandler);

    await serveHandler(router.call);
  } finally {
    authClient.close();
  }
}

CommitRequest _incrementRequest(String projectId) => CommitRequest(
      writes: [
        Write(
          transform: DocumentTransform(
            document:
                'projects/$projectId/databases/(default)/documents/settings/count',
            fieldTransforms: [
              FieldTransform(
                fieldPath: 'count',
                increment: Value(integerValue: '1'),
              )
            ],
          ),
        ),
      ],
    );
