# README

This provides an instruction to set up a hubot in [Slack](https://slack.com/).

Prerequisites
- git
- node installed with [nvm](https://github.com/creationix/nvm), which is used in `.env`
- terraform, `brew install terraform` if brew is available.
- heroku account and [API key](https://dashboard.heroku.com/account)
- [heorku toolbelt](https://toolbelt.heroku.com/)
- Slack account and [a token for hubot](https://kii.slack.com/services/new/hubot)

and, basically only works on MacOSX.

## Launch a heroku instance with terraform
Create a file `heroku.tfvars`
```
email = "youraccount@gmail.com"
api_key = "aaaaaaaa-1111-bbbb-2222-cccccccccccc"
```

Let's say you already have a token of hubot for Slack, type like this.  
```
$ VAR_FILE=heroku.tfvars SLACK_TOKEN=<your-token> make apply
heroku_app.default: Creating...
  config_vars.#:                     "" => "1"
  config_vars.0.HEROKU_URL:          "" => "http://secret-island-8419.herokuapp.com"
  config_vars.0.HUBOT_SLACK_BOTNAME: "" => "secret-island-8419"
...
Outputs:

  heroku_app.default.git_url = git@heroku.com:secret-island-8419.git

```
SLACK\_TOKEN is issued here, https://kii.slack.com/services/new/hubot


## Deploy a new bot onto the heroku instance
On the assumption you've already logged in heroku
```
$ . .env
$ make bot
hubot --create bot
...
```

This will create a new git repository to be deployed onto heroku.
