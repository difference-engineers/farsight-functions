FROM ruby:2.6.3-stretch

ENV BUNDLE_PATH "/home/root/application/vendor/"
ENV BUNDLE_JOBS "2"

WORKDIR /home/root/application/

COPY db/migrate/ db/migrate/
COPY boot.rb .
COPY configuration.rb .
COPY application.rb .
COPY database.rb .
COPY Rakefile .
COPY config.ru .
