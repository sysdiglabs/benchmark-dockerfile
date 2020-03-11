#!/bin/sh

set -eu

DIRECTORY=${1-""}
DOCKERFILE_PATTERN=${2-""}

if [ "$DIRECTORY" = "" ]; then
  $DIRECTORY="./"
fi

if [ "$DOCKERFILE_PATTERN" = "" ]; then
  $DOCKERFILE_PATTERN="dockerfile"
fi

echo "Directory: $DIRECTORY"
echo "Dockerfile pattern: $DOCKERFILE_PATTERN"

report="$(/dockerfile-benchmarker --directory "$DIRECTORY" --dockerfile-pattern "$DOCKERFILE_PATTERN")"

echo $report

echo "::set-output name=violation_report::${report}"
