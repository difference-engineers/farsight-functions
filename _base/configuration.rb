# typed: ignore
SERVICE = ENV.fetch("SERVICE") {ENV.fetch("K_SERVICE")}
VERSION = ENV.fetch("VERSION") {ENV.fetch("K_REVISION").split(".").last}
PRODUCTION = ENV.fetch("DEPLOY_ENV") == "production"
CONSOLE = !!ENV.fetch("CONSOLE", false)

SemanticLogger.default_level = :trace
SemanticLogger.add_signal_handler
SemanticLogger.add_appender(:io => $stdout, :formatter => :one_line) unless defined?(logger)
LOGGER = SemanticLogger[SERVICE]

if CONSOLE
  def Pry.reload!
    $LOADED_FEATURES.grep(/#{SERVICE}/).reject{|file| file.match?(/boot|config|application/)}.each(&method(:load))
  end
end

if PRODUCTION
  Google::Cloud::Debugger.configure do |config|
    config.service_name = SERVICE
    config.service_version = VERSION
  end
end
