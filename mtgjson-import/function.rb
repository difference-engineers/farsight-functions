def function(response:, database:)
  cards = database.relations.fetch(:cards)
  response.write(cards.count.to_s)
  response.status = :ok
end
