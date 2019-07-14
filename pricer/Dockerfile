#Pricer
FROM ruby:2.5.3
WORKDIR /var/www/pricer
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler && bundle install
EXPOSE 8080
COPY . .
CMD ["bundle", "exec", "ruby", "./pricer.rb","-p", "8080", "-e", "production"]
