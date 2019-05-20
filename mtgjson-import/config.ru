require "securerandom"
require "rubygems"
require "bundler"

Bundler.require(:default, ENV.fetch("DEPLOY_ENV", "development"))

require_relative "application"
require_relative "database"
require_relative "function"

run Application.freeze.app
