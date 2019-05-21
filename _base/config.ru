require_relative "boot"
require_relative "application"
require_relative "database"
require_relative "function"

run Application.freeze.app
