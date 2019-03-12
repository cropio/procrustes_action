# GitHub Action which monitor Pull Request size

## How to add as Github Action
1. In action name put `ozeron/procrustes_action@master`
2. That's it

This code expect to work with data from `GITHUB_EVENT_PATH` env variable, so copy payload from github api manualy or use default fixture

## How to run locally
1. Copy `.env.example` to `.env`
2. Copy `GITHUB_TOKEN` in `.env` from [this page](https://github.com/settings/tokens)
3. Run `ruby app.rb` in terminal

## How to run in Docker Container
1. Copy `.env.example` to `.env`
2. Copy `GITHUB_TOKEN` in `.env` from [this page](https://github.com/settings/tokens)
3. Build container `docker build -t ozeron/loc_limiter .`
4. Run `docker run --rm -it --env-file .env ozeron/loc_limiter`

## File whitelist
Now it whitelists \*.rb, \*.slim, \*.js files except spec/, config/
