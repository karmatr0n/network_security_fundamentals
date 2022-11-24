FROM alpine:3.16.2

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  ruby \
  ruby-dev \
  ruby-bundler \
  libpcap \
  libpcap-dev \
  build-base \
  net-tools \
  neovim \
  tcpdump

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY . $APP_HOME/

RUN chmod +x $APP_HOME/mongo_scanner.rb
RUN bundle install

CMD ["ruby", "/app/mongo_scanner.rb", "192.168.72.11", "27017"]
