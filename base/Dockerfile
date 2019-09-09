FROM ruby:2.6.3-stretch

ENV BUNDLE_PATH "/home/root/application/vendor/"
ENV BUNDLE_JOBS "2"
ENV PORT 8080
ENV CONCURRENCY 2

WORKDIR /home/root/application/

COPY db/migrate/ db/migrate/
COPY boot.rb .
COPY configuration.rb .
COPY application.rb .
COPY database.rb .
COPY Rakefile .
COPY Gemfile .
COPY Gemfile.lock .
COPY config.ru .

RUN bundle install --deployment --frozen

EXPOSE 8080

CMD ["bundle", "exec", "falcon serve --threaded --count $CONCURRENCY --bind 'http://0.0.0.0:8080'"]
