ARG PROJECT_ID

FROM gcr.io/$PROJECT_ID/base:latest

ENV NAME "mtgjson-import"

WORKDIR /home/root/application/

ARG DEPLOY_ENV
ARG RACK_ENV
ARG PORT

ENV DEPLOY_ENV ${DEPLOY_ENV:-development}
ENV RACK_ENV ${RACK_ENV:-development}
ENV PORT ${PORT:-8080}

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --deployment --frozen

COPY function.rb .

EXPOSE $PORT

CMD ["bundle", "exec", "falcon serve --threaded --count 1 --bind http://0.0.0.0:$PORT"]
