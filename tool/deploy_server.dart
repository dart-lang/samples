// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

/// Standalone zero-dependency deployment script for Google Cloud Run
/// using the fast direct-source (`osonly24`) base image.
///
/// Usage:
///
/// ```bash
/// dart run tool/deploy_server.dart [target_directory] [options]
/// ```
Future<void> main(List<String> args) async {
  String? targetDirArg;
  String? project;
  String? serviceName;
  String? region;
  String? setEnvVars;
  var dryRun = false;

  // Parse CLI arguments.
  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (arg == '-h' || arg == '--help') {
      _printUsage();
      return;
    } else if (arg == '-n' || arg == '--dry-run') {
      dryRun = true;
    } else if (arg == '-p' || arg == '--project') {
      if (i + 1 >= args.length) _fatal('Missing value for $arg');
      project = args[++i];
    } else if (arg.startsWith('--project=')) {
      project = arg.substring('--project='.length);
    } else if (arg == '-s' || arg == '--service-name') {
      if (i + 1 >= args.length) _fatal('Missing value for $arg');
      serviceName = args[++i];
    } else if (arg.startsWith('--service-name=')) {
      serviceName = arg.substring('--service-name='.length);
    } else if (arg == '-r' || arg == '--region') {
      if (i + 1 >= args.length) _fatal('Missing value for $arg');
      region = args[++i];
    } else if (arg.startsWith('--region=')) {
      region = arg.substring('--region='.length);
    } else if (arg == '--set-env-vars') {
      if (i + 1 >= args.length) _fatal('Missing value for $arg');
      setEnvVars = args[++i];
    } else if (arg.startsWith('--set-env-vars=')) {
      setEnvVars = arg.substring('--set-env-vars='.length);
    } else if (!arg.startsWith('-') && targetDirArg == null) {
      targetDirArg = arg;
    } else {
      _fatal('Unknown argument: $arg\nUse --help for usage.');
    }
  }

  // Determine and resolve target directory.
  final Directory targetDir;
  if (targetDirArg != null) {
    targetDir = Directory(targetDirArg);
  } else {
    // Check if the current directory has a server to deploy.
    if (File('bin/server.dart').existsSync()) {
      targetDir = Directory.current;
    } else {
      stderr.writeln('Error: No target directory specified.');
      _printAvailableSamples();
      exitCode = 1;
      return;
    }
  }

  if (!targetDir.existsSync()) {
    _fatal('Target directory does not exist: ${targetDir.path}');
  }

  final serverEntrypoint = File(_join(targetDir.path, 'bin', 'server.dart'));
  if (!serverEntrypoint.existsSync()) {
    _fatal(
      'Could not find entrypoint: ${serverEntrypoint.path}\n'
      'Make sure the target directory contains a `bin/server.dart` file.',
    );
  }

  // Resolve project configuration.
  project ??= Platform.environment['GCP_PROJECT'];
  region ??= Platform.environment['GCP_REGION'] ?? 'us-central1';

  final dirName = _basename(targetDir.path);
  final defaultServiceName = 'dart-sample-${dirName.replaceAll('_', '-')}';
  serviceName ??= Platform.environment['SERVICE_NAME'] ?? defaultServiceName;

  _validateIdentifier('service-name', serviceName);
  _validateIdentifier('region', region);
  if (project != null && project.isNotEmpty) {
    _validateIdentifier('project', project);
  }

  print('=== Deploying Dart Server to Cloud Run (osonly) ===');
  print('Target Directory : ${targetDir.path}');
  print('Service Name     : $serviceName');
  print('Region           : $region');
  if (project != null && project.isNotEmpty) {
    print('Project          : $project');
  }
  if (setEnvVars != null) {
    print('Env Vars         : $setEnvVars');
  }
  print('==================================================');

  final buildDir = Directory(_join(targetDir.path, 'build'));
  if (buildDir.existsSync()) {
    buildDir.deleteSync(recursive: true);
  }
  final buildBinDir = Directory(_join(buildDir.path, 'bin'));
  buildBinDir.createSync(recursive: true);

  final outputBinary = _join(buildBinDir.path, 'server');

  // 1. Compile to a native AOT executable targeting Linux x64.
  print(
    '\n[1/3] Compiling ${serverEntrypoint.path} to native Linux AOT binary...',
  );
  final compileArgs = [
    'compile',
    'exe',
    serverEntrypoint.path,
    '-o',
    outputBinary,
    '--target-arch',
    'x64',
    '--target-os',
    'linux',
  ];

  await _runProcess(Platform.resolvedExecutable, compileArgs);

  // 2. Copy static public assets if present.
  final publicDir = Directory(_join(targetDir.path, 'public'));
  final destPublicDir = Directory(_join(buildDir.path, 'public'));
  if (publicDir.existsSync()) {
    print('\n[2/3] Copying static assets from ${publicDir.path}...');
    if (destPublicDir.existsSync()) {
      destPublicDir.deleteSync(recursive: true);
    }
    _copyDirectory(publicDir, destPublicDir);
  } else {
    print('\n[2/3] No public/ directory found; skipping asset bundling.');
  }

  // 3. Deploy to Cloud Run using the osonly24 base image without
  // Cloud Build or Docker.
  print('\n[3/3] Deploying to Cloud Run using the direct source (osonly24)...');
  final isWindows = Platform.isWindows;
  final gcloudExecutable = isWindows ? 'gcloud.cmd' : 'gcloud';

  final gcloudArgs = [
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
    buildDir.path,
    '--command=bin/server',
    if (setEnvVars != null && setEnvVars.isNotEmpty)
      '--set-env-vars=$setEnvVars',
  ];

  if (dryRun) {
    print('\n[Dry Run] Would execute:');
    print('$gcloudExecutable ${gcloudArgs.join(' ')}');
    return;
  }

  await _runProcess(gcloudExecutable, gcloudArgs);
  print('\nDeployment complete!');
}

void _printUsage() {
  print('''
Usage: dart run tool/deploy_server.dart [target_directory] [options]

Options:
  -p, --project <id>          GCP Project ID (defaults to GCP_PROJECT or gcloud config)
  -s, --service-name <name>   Cloud Run service name (defaults to "dart-sample-<directory_name>")
  -r, --region <region>       GCP region (defaults to GCP_REGION or "us-central1")
      --set-env-vars <vars>   Comma-separated KEY=VALUE pairs (e.g. STORAGE_BUCKET=my-bucket)
  -n, --dry-run               Compile binary and display gcloud command without deploying
  -h, --help                  Show this help message

Examples:
  dart run tool/deploy_server.dart server/simple
  dart run tool/deploy_server.dart server/cloud_run --project=my-gcp-project
  dart run tool/deploy_server.dart server/cloud_storage --set-env-vars=STORAGE_BUCKET=my-bucket
''');
}

void _printAvailableSamples() {
  print('\nAvailable server samples:');
  final serverDir = Directory('server');
  if (serverDir.existsSync()) {
    for (final entity in serverDir.listSync()) {
      if (entity is Directory &&
          File(_join(entity.path, 'bin', 'server.dart')).existsSync()) {
        print('  - ${entity.path}');
      }
    }
  }
}

Future<void> _runProcess(String executable, List<String> args) async {
  print('Running: $executable ${args.join(' ')}');
  final process = await Process.start(
    executable,
    args,
    mode: ProcessStartMode.inheritStdio,
    runInShell: Platform.isWindows,
  );
  final exitCode = await process.exitCode;
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
  for (final entity in source.listSync(recursive: false)) {
    final newPath = _join(destination.path, _basename(entity.path));
    if (entity is Directory) {
      _copyDirectory(entity, Directory(newPath));
    } else if (entity is File) {
      entity.copySync(newPath);
    }
  }
}

void _validateIdentifier(String name, String value) {
  if (value.contains('&') ||
      value.contains('|') ||
      value.contains(';') ||
      value.contains('<') ||
      value.contains('>') ||
      value.contains('`') ||
      value.contains('\$')) {
    _fatal('Invalid characters in $name: "$value"');
  }
}

String _join(String part1, String part2, [String? part3]) {
  final sep = Platform.pathSeparator;
  var result = part1.endsWith(sep) ? part1 : '$part1$sep';
  result += part2.startsWith(sep) ? part2.substring(1) : part2;
  if (part3 != null) {
    result = result.endsWith(sep) ? result : '$result$sep';
    result += part3.startsWith(sep) ? part3.substring(1) : part3;
  }
  return result;
}

String _basename(String path) {
  var normalized = path;
  final sep = Platform.pathSeparator;
  while (normalized.endsWith(sep) && normalized.length > 1) {
    normalized = normalized.substring(0, normalized.length - 1);
  }
  final index = normalized.lastIndexOf(sep);
  return index == -1 ? normalized : normalized.substring(index + 1);
}

Never _fatal(String message) {
  stderr.writeln('Error: $message');
  exit(1);
}
