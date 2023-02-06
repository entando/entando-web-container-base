#!/bin/bash

. .ent/enp-prereq.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
just-build() {
  local build="$1"
  IFS=',' read -r _dockerFile _dockerImageAddress <<<"${build//=>/,}"
  docker build -t "$ENTANDO_OPT_DOCKER_ORG/$_dockerImageAddress:$ENTANDO_PRJ_VERSION" -f "$_dockerFile" .
}

_log_i "Running build"

_log_i "Building \"$ENTANDO_OPT_DOCKER_ORG/$ENTANDO_PRJ_IMAGE_NAME:$ENTANDO_PRJ_VERSION\""

while IFS= read -r build; do
  echo "$build"
  just-build "$build"
done <<< "${ENTANDO_OPT_DOCKER_BUILDS//,/$'\n'}"



