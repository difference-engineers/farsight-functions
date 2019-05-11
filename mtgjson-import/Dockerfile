FROM jruby:9.2.7.0

ARG MASTER_KEY

ENV MASTER_KEY $MASTER_KEY
ENV NAME "mtgjson-import"
ENV BUNDLE_PATH "/home/root/application/vendor/"
ENV BUNDLE_JOBS "2"

WORKDIR /home/root/application/

COPY Gemfile .
COPY Gemfile.lock .

ARG DEPLOY_ENV
ARG RACK_ENV
ARG PORT

ENV DEPLOY_ENV ${DEPLOY_ENV:-development}
ENV RACK_ENV ${RACK_ENV:-development}
ENV PORT ${PORT:-8080}

RUN bundle install --deployment --frozen

COPY puma.rb config/puma.rb
COPY config.ru .

EXPOSE $PORT

CMD ["bundle", "exec", "puma"]
