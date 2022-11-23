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
COPY tcp_server.rb $APP_HOME/tcp_server.rb
COPY sniffer.rb $APP_HOME/sniffer.rb

RUN chmod +x $APP_HOME/tcp_server.rb
RUN chmod +x $APP_HOME/sniffer.rb
RUN bundle install

CMD ["bundle", "exec", "ruby", "/app/tcp_server.rb"]
