FUNCTION = ENV.fetch("FUNCTION") {ENV.fetch("K_SERVICE")}
VERSION = ENV.fetch("VERSION") {ENV.fetch("K_REVISION").split(".").last}
PRODUCTION = ENV.fetch("DEPLOY_ENV") == "production"

SemanticLogger.default_level = :trace
SemanticLogger.add_signal_handler
SemanticLogger.add_appender(io: $stdout, formatter: :one_line) unless defined?(logger)
SemanticLogger.add_appender(io: logger, formatter: :one_line) if defined?(logger)
LOGGER = SemanticLogger[FUNCTION]
LOGGER.info("Using #{if defined?(logger) then "logger" else "stdout" end}")

if PRODUCTION
  Google::Cloud::Debugger.configure do |config|
    config.service_name = FUNCTION
    config.service_version = VERSION
  end
end
