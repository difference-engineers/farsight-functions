require "rubygems"
require "bundler"
Bundler.setup(:default, ENV.fetch("DEPLOY_ENV", "development"))

run lambda {|env| [200, {}, ["Hello World"]]}
