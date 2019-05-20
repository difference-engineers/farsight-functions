CONFIGURATION = {
  encoding: 'UTF8',
  username: ENV.fetch("POSTGRES_USERNAME"),
  password: ENV.fetch("POSTGRES_PASSWORD"),
  host: ENV.fetch("POSTGRES_HOST")
}
DATABASE = ROM.container(:sql, ENV.fetch("POSTGRES_URI"), CONFIGURATION) do |let|
  # let.default.create_table(:cards) do
  #   primary_key :id
  # end

  let.relation(:cards) do
    schema(infer: true)
  end
end
