class DatabaseSetterMiddleware
  def initialize(application)
    @application = application
  end

  def call(environment)
    environment[:database] = DATABASE
    @application.call(environment)
  end
end
