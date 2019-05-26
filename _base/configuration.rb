SemanticLogger.default_level = :trace
SemanticLogger.add_signal_handler
SemanticLogger.add_appender(io: $stdout, formatter: :color)
LOGGER = SemanticLogger[ENV.fetch("NAME")]
SemanticLogger.flush
