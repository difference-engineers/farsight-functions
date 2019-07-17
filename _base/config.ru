require_relative("boot")
require_relative("configuration")
require_relative("application")
require_relative("database")
require_relative("function")

LOGGER.info("Service: #{SERVICE}")
LOGGER.info("Rack Environment: #{ENV.fetch("RACK_ENV")}")
LOGGER.info("Deploy Environment: #{ENV.fetch("DEPLOY_ENV")}")
LOGGER.info("Concurrency: #{ENV.fetch("CONCURRENCY")}")

use(Google::Cloud::Logging::Middleware) if PRODUCTION
use(Google::Cloud::Debugger::Middleware) if PRODUCTION
use(Google::Cloud::Trace::Middleware) if PRODUCTION
use(Google::Cloud::ErrorReporting::Middleware) if PRODUCTION

run(Application.freeze.app)
