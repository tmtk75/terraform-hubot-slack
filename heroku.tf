variable "email" {}
variable "api_key" {}
variable "slack_token" {}
variable "heroku_app_name" {
    default = "secret-island-8419"
}

provider "heroku" {
    email = "${var.email}"
    api_key = "${var.api_key}"
}

resource "heroku_app" "default" {
    name = "${var.heroku_app_name}"
    stack = "cedar"
    region = "us"
    config_vars {
        HEROKU_URL="http://${var.heroku_app_name}.herokuapp.com"
        HUBOT_SLACK_BOTNAME="${var.heroku_app_name}"
        HUBOT_SLACK_TEAM="kii"
        HUBOT_SLACK_TOKEN="${var.slack_token}"
    }
}

output "heroku_app.default.git_url" {
    value = "${heroku_app.default.git_url}"
}
