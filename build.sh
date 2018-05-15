#!/usr/bin/env bash

ruby_versions=(2.1.10 2.1.8 2.1.9 2.1 2.2.5 2.2.6 2.2 2.3.1 2.3)

for version in "${ruby_versions[@]}"; do
  export RUBY_VERSION=${version}
  echo $RUBY_VERSION
  gucci Dockerfile.tmpl > Dockerfile
  docker build -t iron/rails-nginx-unicorn:ruby${version} .
  docker push iron/rails-nginx-unicorn:ruby${version}
  rm Dockerfile
done;

