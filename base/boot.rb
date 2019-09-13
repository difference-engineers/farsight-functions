# typed: false
require("securerandom")
require("rubygems")
require("bundler")

Bundler.require(:default, ENV.fetch("DEPLOY_ENV", "development"), ENV.fetch("SERVICE").to_sym)
