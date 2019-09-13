# typed: true
def function(request:, database:, logger:)
  uri = URI("https://mtgjson.com/json/AllCards.json")

  logger.info("Fetching cards")
  document = Net::HTTP.get(uri)

  logger.info("Parsing JSON")
  json = JSON.parse(document)

  logger.info("Getting table")
  mtgjson_imports = database.relations.fetch("mtgjson_imports")

  logger.info("Storing cards dump")
  changeset = mtgjson_imports.changeset(:create, :type => "AllCards", :imported_at => Time.now, :raw => json)
  changeset.commit

  logger.info("Finishing")

  [:ok, {}, [mtgjson_imports.count.to_s]]
end
