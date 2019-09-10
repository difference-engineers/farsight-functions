class LoggerSetterMiddleware
  FORMAT = %{%s - %s [%s] "%s %s%s %s" %d %s %0.4f}

  def initialize(application)
    @application = application
  end

  def call(environment)
    began_at = Rack::Utils.clock_time
    environment[:logger] = Async.logger
    environment[Rack::RACK_LOGGER] = Async.logger
    status, header, body = @application.call(environment)
    header = Rack::Utils::HeaderHash.new(header)
    [status, header, Rack::BodyProxy.new(body) { log(environment, status, header, began_at) }]
  end

  private def log(env, status, header, began_at)
    length = extract_content_length(header)

    message = FORMAT % [
      env['HTTP_X_FORWARDED_FOR'] || env["REMOTE_ADDR"] || "-",
      env["REMOTE_USER"] || "-",
      Time.now.strftime("%d/%b/%Y:%H:%M:%S %z"),
      env[Rack::REQUEST_METHOD],
      env[Rack::PATH_INFO],
      env[Rack::QUERY_STRING].empty? ? "" : "?#{env[Rack::QUERY_STRING]}",
      env[Rack::HTTP_VERSION],
      status.to_s[0..3],
      length,
      Rack::Utils.clock_time - began_at ]

    env[Rack::RACK_LOGGER].info(message)
  end

  private def extract_content_length(headers)
    value = headers[Rack::CONTENT_LENGTH]
    !value || value.to_s == '0' ? '-' : value
  end
end
