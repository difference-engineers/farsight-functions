# typed: ignore
class Application < Roda
  plugin(:delete_empty_headers)
  plugin(:request_headers)
  plugin(:symbol_status)
  plugin(:environments)
  plugin(:caching)
  plugin(:common_logger, LOGGER)
  plugin(:cookies, :domain => "difference-engineers.com")
  plugin(:early_hints)
  plugin(:heartbeat)

  route do |router|
    router.root do
      router.get do
        # GET /
        function(:request => request, :response => response, :database => ::DATABASE)
      end
    end
  end
end
