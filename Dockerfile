FROM ruby:2.5
MAINTAINER "Naomichi Yamakita" <n.yamakita@gmail.com>

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y \
    nodejs \
    apt-transport-https \
    mysql-client \
    vim \
    yarn \
    locales \
  && apt-get clean \
  && rm -Rf /var/lib/apt/lists/* \
  && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LC_ALL=ja_JP.UTF-8

# Setup application
RUN mkdir -p /data/rails
WORKDIR /data/rails

COPY Gemfile* /data/rails/
RUN bundle install -j4 --path /usr/local/bundle

COPY . /data/rails
COPY ./etc/docker/rails/docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh

VOLUME /data/rails

CMD ["/bin/docker-entrypoint.sh"]
