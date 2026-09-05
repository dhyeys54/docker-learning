FROM ruby:alpine

WORKDIR /app

RUN apk add --no-cache build-base postgresql-dev

COPY tasks/webserver-ruby/Gemfile .
RUN bundle install

COPY tasks/webserver-ruby/server.rb .

EXPOSE 4567

CMD ["ruby", "server.rb"]
