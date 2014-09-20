## local run
default: brain

slack_botname=`terraform output -state=./terraform.tfstate heroku_app.default.slack_botname`
bot_dir=$(slack_botname).git

bot: hubot redis
	hubot --create $(bot_dir)
	(cd $(bot_dir); \
		git init; git add .; git commit -m "initial commit"; \
		npm install hubot-slack --save; git commit -am "fubot-slack"; \
		cp ../Procfile ./Procfile; git commit -am "--adapter slack"; \
		cp ../hearing.coffee ./scripts; git add scripts/*.coffee; git commit -am "add a simple script to hear"; \
		)

push:
	(cd $(bot_dir); \
		git remote add origin `terraform output -state=../terraform.tfstate heroku_app.default.git_url`; \
		git push origin master; \
		)

brain: redis
	redis-server

hubot: node_modules/.bin/hubot
redis: /usr/local/bin/redis-server

node_modules/.bin/hubot:
	npm install

/usr/local/bin/redis-server:
	brew install redis


## terraform for heroku
tf_opts=-var-file $(VAR_FILE) \
	-var slack_token=$(SLACK_TOKEN) \
	-var slack_botname=$(SLACK_BOTNAME) \
	-var slack_team=$(SLACK_TEAM)
plan:
	terraform plan $(tf_opts)

apply:
	terraform apply $(tf_opts)

show:
	terraform show terraform.tfstate

destroy: destroy.tfplan
	rm -rf $(bot_dir)
	terraform apply destroy.tfplan

destroy.tfplan:
	terraform plan -destroy -out destroy.tfplan $(tf_opts)

distclean:
	rm -f *.tfstate *.tfstate.backup *.tfplan

