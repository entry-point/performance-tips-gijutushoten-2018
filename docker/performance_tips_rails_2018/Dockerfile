FROM ruby:2.5

# base-packages install
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential git default-libmysqlclient-dev

# nodejs install
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs

# yarn install
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock
RUN bundle install

COPY . /myapp
RUN rm -rf /myapp/node_modules

RUN yarn install

CMD ["bundle", "ex", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]