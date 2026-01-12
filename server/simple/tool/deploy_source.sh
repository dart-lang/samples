#!/bin/bash

# This script deploys the server to Google Cloud Run using source deployment.
# See https://docs.cloud.google.com/docs/buildpacks/osonly
# This feature (as of 2026-01-08) is in "Preview" and requires the "beta" gcloud component.

set -e

# Get the directory of this script.
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
# Get the parent directory of the script's directory.
EXPECTED_DIR=$(dirname "$SCRIPT_DIR")
CURRENT_DIR=$(pwd)

if [ "$CURRENT_DIR" != "$EXPECTED_DIR" ]; then
  echo "Error: This script must be run from: $EXPECTED_DIR" >&2
  exit 1
fi

# Configure project from environment variables.
DEFAULT_SERVICE_NAME="dart-sample"
DEFAULT_GCP_REGION="us-central1"

if [ -z "${GCP_PROJECT}" ]; then
  echo "Warning: GCP_PROJECT environment variable not set. Using default project from gcloud configuration." >&2
  PROJECT_ARG=""
else
  PROJECT_ARG="--project=${GCP_PROJECT}"
fi

if [ -z "${SERVICE_NAME}" ]; then
  echo "Warning: SERVICE_NAME environment variable not set, defaulting to '${DEFAULT_SERVICE_NAME}'." >&2
  SERVICE_NAME="${DEFAULT_SERVICE_NAME}"
fi

if [ -z "${GCP_REGION}" ]; then
  echo "Warning: GCP_REGION environment variable not set, defaulting to '${DEFAULT_GCP_REGION}'." >&2
  GCP_REGION="${DEFAULT_GCP_REGION}"
fi

BUILD_DIR="build"
BINARY_LOCATION="bin/server"

# Build and prepare source
mkdir -p ${BUILD_DIR}/bin
dart compile exe bin/server.dart -o ${BUILD_DIR}/${BINARY_LOCATION} --target-arch x64 --target-os linux
cp -r public ${BUILD_DIR}/

# Deploy to Google Cloud Run without using build.
gcloud beta run deploy ${SERVICE_NAME} \
  ${PROJECT_ARG} \
  --region=${GCP_REGION} \
  --allow-unauthenticated \
  --no-build \
  --base-image=osonly24 \
  --source ${BUILD_DIR} \
  --command=${BINARY_LOCATION}
