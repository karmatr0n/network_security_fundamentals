FROM alpine:3.16.2

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  ruby

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY tcp_client.rb $APP_HOME/tcp_client.rb
RUN chmod +x $APP_HOME/tcp_client.rb

CMD ["ruby", "/app/tcp_client.rb"]