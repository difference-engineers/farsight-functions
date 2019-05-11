FROM jruby:9.2.7.0

WORKDIR /home/root/application/

COPY Gemfile .
COPY Gemfile.lock .
COPY config.ru .

ARG MASTER_KEY
ARG DEPLOY_ENV

ENV BUNDLE_PATH "/home/root/application/vendor/"
ENV BUNDLE_JOBS "2"

RUN bundle install --deployment --frozen

EXPOSE 8080

CMD bundle exec falcon serve --bind http://0.0.0.0:8080
