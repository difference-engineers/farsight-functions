class StatusSymbolMiddleware
  def initialize(application)
    @application = application
  end

  def call(environment)
    status, headers, body = @application.call(environment)
    [if status.is_a?(Symbol) || status.is_a?(String) then Rack::Utils.status_code(status.to_sym) else status end, headers, body]
  end
end
