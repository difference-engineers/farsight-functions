ROM::SQL.migration do
  change do
    create_table(:mtgjson_imports) do
      column(:id, :uuid, :primary => true)
      column(:raw, :jsonb, :null => false)
      column(:imported_at, :timestamp, :null => false)
    end
  end
end
