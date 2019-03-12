FROM ruby:2.5

LABEL "com.github.actions.name"="Guard PR LOC limit"
LABEL "com.github.actions.description"="Limit PR adddition size to ADDITIONS_MAX_NUM"
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/ozeron/procrustes"
LABEL "homepage"="https://github.com/ozeron/procrustes"
LABEL "maintainer"="Oleksandr Lapchenko <ozeron@me.com>"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install --without development test

COPY . .

ENTRYPOINT ["ruby", "/app/app.rb"]
