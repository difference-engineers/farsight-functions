FROM us.gcr.io/farsight-239605/base:latest

ENV NAME "mtgjson-import"

WORKDIR /home/root/application/

ARG DEPLOY_ENV
ARG RACK_ENV
ARG PORT
ARG CONCURRENCY

ENV DEPLOY_ENV ${DEPLOY_ENV:-development}
ENV RACK_ENV ${RACK_ENV:-development}
ENV PORT ${PORT:-8080}
ENV CONCURRENCY ${CONCURRENCY:-2}

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --deployment --frozen

COPY function.rb .

EXPOSE $PORT

CMD ["bundle", "exec", "falcon --verbose serve --threaded --count $CONCURRENCY --bind http://0.0.0.0:$PORT"]
