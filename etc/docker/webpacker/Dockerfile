FROM ruby:2.5
MAINTAINER "Naomichi Yamakita" <n.yamakita@gmail.com>

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update \
  && apt-get install -y nodejs yarn vim \
  && apt-get clean \
  && rm -Rf /var/lib/apt/lists/*

ENV APP_HOME /app
WORKDIR $APP_HOME
CMD ["./bin/webpack-dev-server"]
