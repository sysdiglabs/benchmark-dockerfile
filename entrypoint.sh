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

if [ "$DOCKERFILE_PATTERN" != "" ]; then
  DOCKERFILE_PATTERN="dockerfile"
fi


echo "Directory: $DIRECTORY"
echo "Dockerfile pattern: $DOCKERFILE_PATTERN"
echo "Disallowed Packages: $DISALLOWD_PACKAGES"
echo "Trusted base images: $TRUSTED_BASE_IMAGES"
echo "Secret patterns: $SECRET_PATTERNS"


report=$(/dockerfile-benchmarker --directory "$DIRECTORY" --dockerfile-pattern "$DOCKERFILE_PATTERN" --disallowed-packages "$DISALLOWD_PACKAGES" --trusted-base-images "$TRUSTED_BASE_IMAGES" --secret-patterns "$SECRET_PATTERNS")

echo $report

echo "violation_report=${report}" >> $GITHUB_OUTPUT
