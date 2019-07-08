ROM::SQL.migration do
  change do
    create_table(:mtgjson_imports) do
      primary_key(:id, :bigint)
      column(:raw, :jsonb, :null => false)
      column(:imported_at, :timestamp, :null => false)
    end
  end
end
