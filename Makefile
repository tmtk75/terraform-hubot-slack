## local run
default: brain

bot: hubot redis
	hubot --create bot
	(cd bot; \
		git init; git add .; git commit -m "initial commit"; \
		npm install hubot-slack --save; git commit -am "fubot-slack"; \
		cp ../Procfile ./Procfile; git commit -am "--adapter slack"; \
		)

push:
	(cd bot; \
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
tf_opts=-var-file $(VAR_FILE) -var slack_token=$(SLACK_TOKEN) -var slack_botname=$(SLACK_BOTNAME)
plan:
	terraform plan $(tf_opts)

apply:
	terraform apply $(tf_opts)

show:
	terraform show terraform.tfstate

destroy: destroy.tfplan
	terraform apply destroy.tfplan

destroy.tfplan:
	terraform plan -destroy -out destroy.tfplan $(tf_opts)

distclean:
	rm -f *.tfstate *.tfstate.backup *.tfplan

