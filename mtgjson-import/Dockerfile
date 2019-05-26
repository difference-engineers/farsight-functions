FROM us.gcr.io/farsight-239605/base:latest

ENV NAME "mtgjson-import"

WORKDIR /home/root/application/

ENV PORT 8080

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --deployment --frozen

COPY function.rb .

EXPOSE $PORT

CMD ["bundle", "exec", "falcon serve --threaded --count $CONCURRENCY --bind http://0.0.0.0:$PORT"]
