FROM ruby:2.5

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . .

ENTRYPOINT ["ruby", "/app/app.rb"]
