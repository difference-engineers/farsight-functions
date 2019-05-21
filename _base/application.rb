class Application < Roda
  plugin :common_logger, STDOUT

  route do |router|
    router.root do
      router.get do
        function(router: router, response: response, database: ::DATABASE)
      end
    end
  end
end
