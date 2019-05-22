require_relative "boot"
require_relative "configuration"
require_relative "application"
require_relative "database"
require_relative "function"

use Rack::Logger, Logger::DEBUG

run Application.freeze.app
