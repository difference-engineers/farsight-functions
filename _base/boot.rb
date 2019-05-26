require "securerandom"
require "rubygems"
require "bundler"

$stdout = IO.new(IO.sysopen("/proc/1/fd/1", "w"),"w")
$stdout.sync = true
STDOUT = $stdout

$stderr = IO.new(IO.sysopen("/proc/1/fd/1", "w"),"w")
$stderr.sync = true
STDERR = $stderr

Bundler.require(:default, ENV.fetch("DEPLOY_ENV", "development"))
