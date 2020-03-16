#!/bin/sh

set -eu

DIRECTORY=${1-""}
DOCKERFILE_PATTERN=${2-""}
DISALLOWD_PACKAGES=${3-""}
TRUSTED_BASE_IMAGES=${4-""}
SECRET_PATTERNS=${5-""}

if [ "$DIRECTORY" = "" ]; then
  DIRECTORY="./"
fi

if [ "$DOCKERFILE_PATTERN" = "" ]; then
  DOCKERFILE_PATTERN="dockerfile"
fi

CMD="/dockerfile-benchmarker --directory $DIRECTORY --dockerfile-pattern $DOCKERFILE_PATTERN"

if [ "$DISALLOWD_PACKAGES" = "" ]; then
  CMD+=" --disallowed-packages $DISALLOWD_PACKAGES"
fi

if [ "$TRUSTED_BASE_IMAGES" = "" ]; then
  CMD+=" --trusted-base-images $TRUSTED_BASE_IMAGES"
fi

if [ "$SECRET_PATTERNS" = "" ]; then
  CMD+=" --secret-patterns $SECRET_PATTERNS"
fi

echo "Directory: $DIRECTORY"
echo "Dockerfile pattern: $DOCKERFILE_PATTERN"
echo "Disallowed Packages: $DISALLOWD_PACKAGES"
echo "Trusted base images: $TRUSTED_BASE_IMAGES"
echo "Secret patterns: $SECRET_PATTERNS"

echo "$CMD"

report="$(CMD)"

echo $report

echo "::set-output name=violation_report::${report}"
