# typed: ignore
DATABASE = ROM.container(:sql, ENV.fetch("POSTGRES_URI"), {
  :encoding => "UTF8",
  :username => ENV.fetch("POSTGRES_USERNAME"),
  :password => ENV.fetch("POSTGRES_PASSWORD"),
  :host => ENV.fetch("POSTGRES_HOST"),
  :extensions => [
    :pg_array,
    :pg_json,
    :pg_range,
    :pg_enum,
    :pg_inet,
    :pg_row,
    :pg_extended_date_support,
    :pg_loose_count,
    :sql_comments,
    :caller_logging,
    :connection_expiration,
    :connection_validator,
  ],
}) do |let|
  let.gateways.fetch(:default).use_logger(LOGGER)

  let.relation(:cards) do
    schema(:infer => true)
  end

  let.relation(:mtgjson_imports) do
    schema(:infer => true)
  end
end
