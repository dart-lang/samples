// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io' hide exit;
import 'package:args/args.dart';
import 'package:path/path.dart' as path;

Future<void> main(List<String> arguments) async {
  ArgResults results;
  try {
    results = _parser.parse(arguments);
  } on ArgParserException catch (e) {
    stderr.writeln('Error: ${e.message}');
    _printUsage(_parser);
    exitCode = 1;
    return;
  }

  if (results['help'] as bool) {
    _printUsage(_parser);
    return;
  }

  // Ensure script is run from the project root.
  var scriptFile = File(Platform.script.toFilePath());
  var expectedDir = scriptFile.parent.parent;
  var currentDir = Directory.current;

  if (path.canonicalize(currentDir.path) !=
      path.canonicalize(expectedDir.path)) {
    stderr.writeln('Error: This script must be run from: ${expectedDir.path}');
    exitCode = 1;
    return;
  }

  var project = _resolveOption(
    results: results,
    optionName: 'project',
    envVarName: 'GCP_PROJECT',
    warningMessage:
        'GCP_PROJECT environment variable and --project flag not set. Using default project from gcloud configuration.',
  );

  var serviceName = _resolveOption(
    results: results,
    optionName: 'service-name',
    envVarName: 'SERVICE_NAME',
    defaultValue: 'dart-sample',
    warningMessage:
        'SERVICE_NAME environment variable and --service-name flag not set',
  )!;

  var region = _resolveOption(
    results: results,
    optionName: 'region',
    envVarName: 'GCP_REGION',
    defaultValue: 'us-central1',
    warningMessage: 'GCP_REGION environment variable and --region flag not set',
  )!;

  var buildBinDir = Directory(path.join('build', 'bin'));
  if (!buildBinDir.existsSync()) {
    buildBinDir.createSync(recursive: true);
  }

  // Build and prepare Dart source.
  var dartExecutable = Platform.resolvedExecutable;
  var compileArgs = [
    'compile',
    'exe',
    path.join('bin', 'server.dart'),
    '-o',
    path.join('build', 'bin', 'server'),
    '--target-arch',
    'x64',
    '--target-os',
    'linux',
  ];

  await _runProcess(dartExecutable, compileArgs);

  // Copy public directory to build directory.
  var publicDir = Directory('public');
  if (publicDir.existsSync()) {
    _copyDirectory(publicDir, Directory(path.join('build', 'public')));
  } else {
    stderr.writeln('Warning: public directory not found.');
  }

  // Deploy to Google Cloud Run without using build.
  var isWindows = Platform.isWindows;
  var gcloudExecutable = isWindows ? 'gcloud.cmd' : 'gcloud';
  var gcloudArgs = [
    'beta',
    'run',
    'deploy',
    serviceName,
    if (project != null && project.isNotEmpty) '--project=$project',
    '--region=$region',
    '--allow-unauthenticated',
    '--no-build',
    '--base-image=osonly24',
    '--source',
    'build',
    '--command=bin/server',
  ];

  await _runProcess(gcloudExecutable, gcloudArgs);
}

void _validateArgument(String name, String value) {
  if (value.contains('&') ||
      value.contains('|') ||
      value.contains(';') ||
      value.contains('<') ||
      value.contains('>')) {
    throw ArgumentError('Invalid characters in argument $name.');
  }
}

void _printUsage(ArgParser parser) {
  print('Usage: dart tool/deploy_source.dart [options]\n');
  print(parser.usage);
}

Future<void> _runProcess(String executable, List<String> args) async {
  print('Running: $executable ${args.join(' ')}');
  var process = await Process.start(
    executable,
    args,
    mode: ProcessStartMode.inheritStdio,
    runInShell: Platform.isWindows,
  );
  var exitCode = await process.exitCode;
  if (exitCode != 0) {
    throw ProcessException(
      executable,
      args,
      'Command failed with exit code $exitCode',
      exitCode,
    );
  }
}

void _copyDirectory(Directory source, Directory destination) {
  if (!destination.existsSync()) {
    destination.createSync(recursive: true);
  }
  for (var entity in source.listSync(recursive: false)) {
    var newPath = path.join(destination.path, path.basename(entity.path));
    if (entity is Directory) {
      _copyDirectory(entity, Directory(newPath));
    } else if (entity is File) {
      entity.copySync(newPath);
    }
  }
}

String? _resolveOption({
  required ArgResults results,
  required String optionName,
  required String envVarName,
  String? defaultValue,
  required String warningMessage,
}) {
  var value =
      results[optionName] as String? ?? Platform.environment[envVarName];
  if (value == null || value.isEmpty) {
    if (defaultValue != null) {
      stderr.writeln(
        "Warning: $warningMessage, defaulting to '$defaultValue'.",
      );
    } else {
      stderr.writeln('Warning: $warningMessage');
    }
    value = defaultValue;
  }
  if (value != null) {
    _validateArgument(optionName, value);
  }
  return value;
}

final _parser = ArgParser()
  ..addOption(
    'project',
    abbr: 'p',
    help:
        'GCP Project ID (defaults to GCP_PROJECT environment variable or gcloud default).',
  )
  ..addOption(
    'service-name',
    abbr: 's',
    help:
        'Cloud Run service name (defaults to SERVICE_NAME environment variable or "dart-sample").',
  )
  ..addOption(
    'region',
    abbr: 'r',
    help:
        'GCP region (defaults to GCP_REGION environment variable or "us-central1").',
  )
  ..addFlag(
    'help',
    abbr: 'h',
    negatable: false,
    help: 'Show this help message.',
  );
