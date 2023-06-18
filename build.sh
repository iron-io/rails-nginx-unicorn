#!/usr/bin/env bash

ruby_versions=(2.7.6)

for version in "${ruby_versions[@]}"; do
  export RUBY_VERSION=${version}
  echo $RUBY_VERSION
  gucci Dockerfile.tmpl > Dockerfile
  docker build -t iron/rails-nginx-unicorn:ruby${version} .
  docker push iron/rails-nginx-unicorn:ruby${version}
  rm Dockerfile
done;

