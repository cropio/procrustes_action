# Simple service which works webhooks and monitor pull request size

## Configuration
- Set `GITHUB_API_KEY` in `.env`
- Set `GITHUB_EVENT_PATH` to `spec/fixtures/github.event.json` or smth similar.

Now it whitelists \*.rb, \*.slim, \*.js files except spec

To run execute
```bash
ruby app.rb
```
