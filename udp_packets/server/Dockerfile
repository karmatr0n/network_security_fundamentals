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
  arp-scan \
  tcpdump

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
COPY udp_server.rb $APP_HOME/udp_server.rb
COPY sniffer.rb $APP_HOME/sniffer.rb

RUN chmod +x $APP_HOME/udp_server.rb
RUN bundle install

ENTRYPOINT ["bundle", "exec", "ruby", "/app/udp_server.rb"]
