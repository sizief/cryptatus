#Ticker
FROM ruby:2.5.3
WORKDIR /var/www/ticker
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler && bundle install
EXPOSE 8080
COPY . .
CMD ["./bin/server.sh"]
