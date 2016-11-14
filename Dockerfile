FROM ruby:2.2.5
MAINTAINER iron.io

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -qq -y software-properties-common wget vim

# install nginx
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
  && echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -qq -y nginx=1.10.2-1~jessie

# install foreman
RUN gem install foreman \
  && gem install unicorn

# install the latest postgresql lib for pg gem
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    apt-get install -y --force-yes libpq-dev

# install MySQL(for mysql, mysql2 gem)
RUN apt-get install -qq -y libmysqlclient-dev

# install dockerize
RUN wget -q https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz

RUN apt-get clean \
  && cd /var/lib/apt/lists && rm -fr *Release* *Sources* *Packages* \
  && truncate -s 0 /var/log/*log

# install Rails App
WORKDIR /app
ENV RAILS_ENV production
ONBUILD ADD Gemfile /app/Gemfile
ONBUILD ADD Gemfile.lock /app/Gemfile.lock
ONBUILD RUN bundle install --without development test
ONBUILD ADD . /app
ONBUILD RUN bundle exec rake assets:precompile

ADD nginx-sites.conf /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/nginx.conf
ADD unicorn.rb /app/config/unicorn.rb
ADD Procfile /app/Procfile

CMD foreman start -f Procfile
