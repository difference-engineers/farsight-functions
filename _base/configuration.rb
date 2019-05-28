NAME = ENV.fetch("NAME") {ENV.fetch("K_SERVICE")}
VERSION = ENV.fetch("VERSION") {ENV.fetch("K_SERVICE")}
PRODUCTION = ENV.fetch("DEPLOY_ENV") == "production"

IO = if defined?(logger) then logger else $stdout end
SemanticLogger.default_level = :trace
SemanticLogger.add_signal_handler
SemanticLogger.add_appender(io: IO, formatter: :one_line)
SemanticLogger.add_appender(io: logger, formatter: :one_line)
LOGGER = SemanticLogger[NAME]
LOGGER.info("Using #{if defined?(logger) then "logger" else "stdout" end}")

if PRODUCTION
  Google::Cloud::Debugger.configure do |config|
    config.service_name = NAME
    config.service_version = VERSION
  end
end
