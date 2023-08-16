#!/usr/bin/env bash

find . \
  -not -path '*\.json' \
  -not -path '*\.md' \
  -not -path '*\.yaml' \
  -not -path '*/\.*' \
  -not -iname "LICENSE" \
  -not -iname "Makefile" \
  -not -path './docs/*' \
  -not -iname 'flake\.*' \
  -not -path './scripts/*' \
  "$@"
