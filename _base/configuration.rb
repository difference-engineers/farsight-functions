SERVICE = ENV.fetch("SERVICE") {ENV.fetch("K_SERVICE")}
VERSION = ENV.fetch("VERSION") {ENV.fetch("K_REVISION").split(".").last}
PRODUCTION = ENV.fetch("DEPLOY_ENV") == "production"

SemanticLogger.default_level = :trace
SemanticLogger.add_signal_handler
SemanticLogger.add_appender(io: $stdout, formatter: :one_line) unless defined?(logger)
LOGGER = SemanticLogger[SERVICE]

if PRODUCTION
  Google::Cloud::Debugger.configure do |config|
    config.service_name = SERVICE
    config.service_version = VERSION
  end
end
