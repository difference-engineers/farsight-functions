module Relations
  class Cards < ROM::Relation[:sql]
    schema(infer: true)
  end
end
