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
  iproute2 \
  net-tools \
  neovim \
  arp-scan \
  tcpdump 

ENV APP_HOME /app
RUN mkdir $APP_HOME

WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock
COPY arp_poison.rb $APP_HOME/arp_poison.rb
COPY sniffer.rb $APP_HOME/sniffer.rb


RUN chmod +x $APP_HOME/arp_poison.rb
RUN chmod +x $APP_HOME/sniffer.rb
RUN bundle install

CMD ["bundle", "exec", "ruby", "/app/arp_poison.rb"]