require "rubygems"
require "bundler"
Bundler.setup(:default, ENV.fetch("DEPLOY_ENV", "development"))
Bundler.require(:default, ENV.fetch("DEPLOY_ENV", "development"))

DATABASE_CONFIGURATION = ROM::Configuration.new(
  :sql,
  ENV.fetch("POSTGRES_URI"),
  username: ENV.fetch("POSTGRES_USERNAME"),
  password: ENV.fetch("POSTGRES_PASSWORD")
)

DATABASE_CONFIGURATION.auto_registration

p Relations::Cards.map(&:name)

run lambda {|env| [200, {}, []]}
