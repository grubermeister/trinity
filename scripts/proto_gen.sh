#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
PROTO_DIR="$ROOT_DIR/proto"
GO_OUT="$ROOT_DIR/server/gen/go"
DART_OUT="$ROOT_DIR/client/flutter_app/lib/gen"


mkdir -p "$GO_OUT" "$DART_OUT"


# Go plugins
protoc \
  -I"$PROTO_DIR" \
  --go_out="$GO_OUT" --go_opt=paths=source_relative \
  --go-grpc_out="$GO_OUT" --go-grpc_opt=paths=source_relative \
  $(find "$PROTO_DIR" -name '*.proto')


# Dart plugin (requires dart-protoc-plugin in PATH)
protoc \
  -I"$PROTO_DIR" \
  --dart_out="$DART_OUT" \
  $(find "$PROTO_DIR" -name '*.proto')


echo "Protobufs generated for Go and Dart."