CONFIGURATION = {
  encoding: 'UTF8',
  username: ENV.fetch("POSTGRES_USERNAME"),
  password: ENV.fetch("POSTGRES_PASSWORD"),
  host: ENV.fetch("POSTGRES_HOST"),
  extensions: [:pg_array, :pg_json, :pg_loose_count, :pg_range, :connection_validator]
}
DATABASE = ROM.container(:sql, ENV.fetch("POSTGRES_URI"), CONFIGURATION) do |let|
  let.gateways.fetch(:default).run_migrations if let.gateways.fetch(:default).pending_migrations?

  let.relation(:cards) do
    schema(infer: true)
  end unless ENV.fetch("MIGRATION", false)
end
