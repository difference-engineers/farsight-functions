require_relative "boot"
require_relative "configuration"
require_relative "application"
require_relative "database"
require_relative "function"

LOGGER.info("Name: #{ENV.fetch("NAME")}")
LOGGER.info("Rack Environment: #{ENV.fetch("RACK_ENV")}")
LOGGER.info("Deploy Environment: #{ENV.fetch("DEPLOY_ENV")}")
LOGGER.info("Concurrency: #{ENV.fetch("CONCURRENCY")}")

run Application.freeze.app
