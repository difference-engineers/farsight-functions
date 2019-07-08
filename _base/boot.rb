require("securerandom")
require("rubygems")
require("bundler")

$stdout.sync = true
$stderr.sync = true

Bundler.require(:default, ENV.fetch("DEPLOY_ENV", "development"), ENV.fetch("SERVICE").to_sym)
