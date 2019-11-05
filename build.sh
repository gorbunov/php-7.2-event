#!/usr/bin/env bash
docker image build --no-cache -t ogorbunov/php:7.3-event .
if [ $? -eq 0 ]
then
  docker image push ogorbunov/php:7.3-event
fi
