require_relative("boot")
require_relative("configuration")
require_relative("database")
require_relative("function")
require_relative("middleware/logger_setter_middleware")
require_relative("middleware/database_setter_middleware")
require_relative("middleware/request_setter_middleware")
require_relative("middleware/status_symbol_middleware")

Async.logger.info("Service: #{SERVICE}")
Async.logger.info("Rack Environment: #{ENV.fetch("RACK_ENV")}")
Async.logger.info("Deploy Environment: #{ENV.fetch("DEPLOY_ENV")}")
Async.logger.info("Concurrency: #{ENV.fetch("CONCURRENCY")}")

use(Google::Cloud::Logging::Middleware) if PRODUCTION
use(Google::Cloud::Debugger::Middleware) if PRODUCTION
use(Google::Cloud::Trace::Middleware) if PRODUCTION
use(Google::Cloud::ErrorReporting::Middleware) if PRODUCTION
use(Hanami::Middleware::BodyParser, :json)
use(LoggerSetterMiddleware)
use(DatabaseSetterMiddleware)
use(RequestSetterMiddleware)
use(StatusSymbolMiddleware)

run(
  Hanami::Router.new do
    get "/" do |env|
      function(request: env[:request], database: env[:database], logger: env[:logger])
    end
    post "/" do |env|
      function(request: env[:request], database: env[:database], logger: env[:logger])
    end
    put "/" do |env|
      function(request: env[:request], database: env[:database], logger: env[:logger])
    end
    patch "/" do |env|
      function(request: env[:request], database: env[:database], logger: env[:logger])
    end
    delete "/" do |env|
      function(request: env[:request], database: env[:database], logger: env[:logger])
    end
    trace "/" do |env|
      function(request: env[:request], database: env[:database], logger: env[:logger])
    end
  end
)
