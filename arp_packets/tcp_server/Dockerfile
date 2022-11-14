FROM alpine:3.16.2

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  ruby

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY tcp_server.rb $APP_HOME/tcp_server.rb
RUN chmod +x $APP_HOME/tcp_server.rb

CMD ["ruby", "/app/tcp_server.rb"]