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


COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

COPY tcp_client.rb $APP_HOME/tcp_client.rb
COPY tcp_handshake.rb $APP_HOME/tcp_handshake.rb

RUN chmod +x $APP_HOME/tcp_client.rb
RUN chmod +x $APP_HOME/tcp_handshake.rb
RUN bundle install

CMD ["ruby", "/app/tcp_client.rb"]
