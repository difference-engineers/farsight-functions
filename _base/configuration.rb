SemanticLogger.default_level = :trace
SemanticLogger.add_appender(io: STDOUT, formatter: :color)
LOGGER = SemanticLogger[ENV.fetch("NAME")]
