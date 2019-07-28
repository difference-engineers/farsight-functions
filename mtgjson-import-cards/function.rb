# typed: true
def function(response:, router:, database:)
  uri = URI("https://mtgjson.com/json/AllCards.json")
  document = Net::HTTP.get(uri)
  json = JSON.parse(document)

  mtgjson_imports = database.relations.fetch("mtgjson_imports")
  changeset = mtgjson_imports.changeset(:create, "type" => "AllCards", "imported_at" => Time.now, "raw" => json)
  changeset.commit

  response.write(mtgjson_imports.count.to_s)
  response.status = :ok
end
