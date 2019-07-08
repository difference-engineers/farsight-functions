FROM us.gcr.io/farsight-239605/base:latest

ENV SERVICE "mtgjson-import"

WORKDIR /home/root/application/

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --deployment --frozen

COPY function.rb .
