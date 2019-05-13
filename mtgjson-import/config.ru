require "securerandom"
require "rubygems"
require "bundler"

Bundler.require(:default, ENV.fetch("DEPLOY_ENV", "development"))

ORM = ROM.container(:sql, ENV.fetch("POSTGRES_URI"), {
  encoding: 'UTF8',
  username: ENV.fetch("POSTGRES_USERNAME"),
  password: ENV.fetch("POSTGRES_PASSWORD")
}) do |let|
  let.default.create_table(:cards) do
    primary_key :id
  end

  let.relation(:cards) do
    schema(infer: true)
    auto_struct true
  end
end


run ->(env) do
  ORM.relations[:cards].changeset(:create, id: SecureRandom.uuid).commit

  p

  [200, {}, [ORM.relations[:cards].map {|row| row.fetch(:id)}.join(",")]]
end
