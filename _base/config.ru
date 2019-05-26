require_relative "boot"
require_relative "configuration"
require_relative "application"
require_relative "database"
require_relative "function"

LOGGER.info("Rack Environment: #{ENV.fetch("RACK_ENV")}")
LOGGER.info("Deploy Environment: #{ENV.fetch("DEPLOY_ENV")}")

run Application.freeze.app
