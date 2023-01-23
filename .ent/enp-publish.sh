#!/bin/bash

. .ent/enp-prereq.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_log_i "Running publication"

docker login "$ENTANDO_PRJ_IMAGE_REGISTRY" \
  --username "$ENTANDO_OPT_DOCKER_USERNAME" \
  --password-stdin <<< "$ENTANDO_OPT_DOCKER_PASSWORD"

builds="entando-eap73-clustered-base,entando-tomcat-base,entando-wildfly17-base"

while IFS= read -r build; do
  echo "$build"
  IMAGE="$ENTANDO_OPT_DOCKER_ORG/$build:$ENTANDO_PRJ_VERSION"
  _log_i "Publishing \"$IMAGE\" to \"$ENTANDO_PRJ_IMAGE_REGISTRY\""

  docker tag "$IMAGE" "$ENTANDO_PRJ_IMAGE_REGISTRY/$IMAGE"
  docker push "$ENTANDO_PRJ_IMAGE_REGISTRY/$IMAGE"
done <<< "${builds//,/$'\n'}"


