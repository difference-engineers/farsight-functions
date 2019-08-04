# typed: true
def function(request:, response:, database:)
  uri = URI("https://mtgjson.com/json/AllSets.json")
  document = Net::HTTP.get(uri)
  json = JSON.parse(document)

  mtgjson_imports = database.relations.fetch("mtgjson_imports")
  changeset = mtgjson_imports.changeset(:create, "type" => "AllSets", "imported_at" => Time.now, "raw" => json)
  changeset.commit

  response.write(mtgjson_imports.count.to_s)
  response.status = :ok
end
