require "rubygems"
require "bundler"

Bundler.require(:default, ENV.fetch("DEPLOY_ENV", "development"))

CONFIGURATION =

# TODO: Figure out why I need this?
# class Application
#
# end

ORM = ROM.container(:sql, ENV.fetch("POSTGRES_URI"), {
  encoding: 'UTF8',
  username: ENV.fetch("POSTGRES_USERNAME"),
  password: ENV.fetch("POSTGRES_PASSWORD")
}) do |let|
  # let.default.create_table(:cards) do
  #   primary_key :id
  #   column :name, String, null: false
  # end

  let.relation(:cards) do
    schema(infer: true)
    auto_struct true
  end
end


run ->(env) do
  ORM.relations[:cards].changeset(:create, name: "Test").commit

  p ORM.relations[:cards].map(&:name)

  [200, {}, []]
end
