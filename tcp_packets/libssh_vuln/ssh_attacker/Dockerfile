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
  vim \
  arp-scan \
  tcpdump

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
COPY rce_libssh.rb $APP_HOME/rce_libssh.rb

RUN chmod +x $APP_HOME/rce_libssh.rb
RUN bundle install

CMD ["bundle", "exec", "ruby", "/app/rce_libssh.rb", "192.168.52.11", "22", "id"]
