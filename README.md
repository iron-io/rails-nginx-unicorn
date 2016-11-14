# Rails(+ Nginx, Unicorn) Dockerfile

Forked from https://github.com/seapy/dockerfiles/tree/master/rails-nginx-unicorn

Easy useable docker for rails. less configuration, affordable production.

## What's include

* unicorn, nginx, foreman
* mysql, postgresql lib

# Usage

* Create `Dockerfile` to your project and paste below code.

```
# Dockerfile
FROM iron/rails-nginx-unicorn
MAINTAINER iron.io

EXPOSE 80 443
```

To use ssl you will have to mount your SSL key/crt to `/etc/nginx/ssl/server{crt,key}`

*NOTE*: assets are precompiled at build time, not run time to save on start time. You should specify the RAILS_ENV you want to use in your Dockerfile as well.

## Build and run docker

```
# build your dockerfile
$ docker build -t your/project .

# run container
$ docker run -d -p 80:80 -e SECRET_KEY_BASE=secretkey your/project
```

# Customize Nginx, Unicorn, foreman config

## Nginx

```
# your Dockerfile
...
ADD config/your-custom-nginx.conf /etc/nginx/sites-enabled/default
...
```

## Unicorn

place your unicorn config to `config/unicorn.rb`

## foreman

place your Procfile to app root


# Use a specific version of Ruby, Nginx

TODO: automatically build different images here.

# TODO

* github connection setting(like bitbucket)
