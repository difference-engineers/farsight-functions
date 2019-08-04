# typed: true
def function(request:, response:, database:)
  uri = URI("https://mtgjson.com/json/AllCards.json")

  LOGGER.info("Fetching cards")
  document = Net::HTTP.get(uri)

  LOGGER.info("Parsing JSON")
  json = JSON.parse(document)

  LOGGER.info("Getting table")
  mtgjson_imports = database.relations.fetch("mtgjson_imports")

  LOGGER.info("Storing cards dump")
  changeset = mtgjson_imports.changeset(:create, :type => "AllCards", :imported_at => Time.now, :raw => json)
  changeset.commit

  LOGGER.info("Finishing")
  response.write(mtgjson_imports.count.to_s)
  response.status = :ok
end
