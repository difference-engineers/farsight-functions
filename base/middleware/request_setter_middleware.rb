class RequestSetterMiddleware
  def initialize(application)
    @application = application
  end

  def call(environment)
    environment[:request] = Rack::Request.new(environment)
    environment["HTTP_X_REQUEST_ID"] ||= SecureRandom.uuid()
    @application.call(environment)
  end
end
module Rack::LogRequestID
  def initialize(app); @app = app; end

  def call(env)
    puts "request_id=#{env['HTTP_X_REQUEST_ID']}"
    @app.call(env)
  end
end
