FROM ruby:alpine

WORKDIR /app

RUN apk add --no-cache build-base postgresql-dev

COPY Gemfile .
RUN bundle install

COPY server.rb .

EXPOSE 4567

CMD ["ruby", "server.rb"]
