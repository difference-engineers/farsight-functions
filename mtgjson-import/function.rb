def function(router:, response:, database:)
  cards = database.relations.fetch(:cards)
  response.status = 200
  response.write(cards.count.to_s)
end
