#Pricer
FROM ruby:2.5.3
WORKDIR /var/www/pricer
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler && bundle install
COPY . .
CMD ["./bin/server.sh"]
