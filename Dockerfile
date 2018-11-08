FROM ruby:2.5.1
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs && \
    apt-get install -y libpq-dev
WORKDIR /app
COPY ./Gemfile* ./
RUN bundle install
COPY . .

ENTRYPOINT [ "/app/docker-entry.sh" ]
CMD bundle exec rails s -p 3000 -b '0.0.0.0'
