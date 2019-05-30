FUNCTION = ENV.fetch("FUNCTION") {ENV.fetch("K_SERVICE")}
VERSION = ENV.fetch("VERSION") {ENV.fetch("K_REVISION").split(".").last}
PRODUCTION = ENV.fetch("DEPLOY_ENV") == "production"

SemanticLogger.default_level = :trace
SemanticLogger.add_signal_handler
SemanticLogger.add_appender(io: $stdout, formatter: :one_line) unless defined?(logger)
LOGGER = SemanticLogger[FUNCTION]

if PRODUCTION
  Google::Cloud::Debugger.configure do |config|
    config.service_name = FUNCTION
    config.service_version = VERSION
  end
end
