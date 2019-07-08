def function(response:, router:, database:)
  uri = URI('https://mtgjson.com/json/AllCards.json')
  response = Net::HTTP.get(uri)
  json = JSON.parse(response)

  mtgjson_imports = database.relations.fetch("mtgjson_imports")
  changeset = mtgjson_imports.changeset(:create, {"imported_at" => Time.now, 'raw' => json })
  changeset.commit

  response.write(mtgjson_imports.count.to_s)
  response.status = :ok
end
