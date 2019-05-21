FROM ruby:2.6.3-stretch

ENV BUNDLE_PATH "/home/root/application/vendor/"
ENV BUNDLE_JOBS "2"

WORKDIR /home/root/application/

ARG DEPLOY_ENV
ARG RACK_ENV
ARG PORT

ENV DEPLOY_ENV ${DEPLOY_ENV:-development}
ENV RACK_ENV ${RACK_ENV:-development}
ENV PORT ${PORT:-8080}

COPY db/migrate/ db/migrate/
COPY boot.rb .
COPY application.rb .
COPY database.rb .
COPY Rakefile .
COPY config.ru .
