#!/usr/bin/env bash

set -euo pipefail

readonly TAG="${*}"

docker buildx build \
	--build-arg TAG="${TAG}" \
	--tag "ghcr.io/alexandrepicavet/httpd-webdav:${TAG}" \
	.
