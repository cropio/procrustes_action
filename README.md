# GitHub Action which monitor Pull Request size


## Running locally
1. Copy `.env.example` to `.env`
2. Copy `GITHUB_TOKEN` in `.env` from [this page](https://github.com/settings/tokens)
3. Run `ruby app.rb` in terminal

## Running in container
1. Copy `.env.example` to `.env`
2. Copy `GITHUB_TOKEN` in `.env` from [this page](https://github.com/settings/tokens)
3. Build container `docker build -t ozeron/loc_limiter .`
4. Run `docker run --rm -it --env-file .env ozeron/loc_limiter`

## File whitelist
Now it whitelists \*.rb, \*.slim, \*.js files except spec/, config/
