ROM::SQL.migration do
  change do
    create_table(:cards) do
      primary_key :id, :bigint
      column :raw, :jsonb, null: false
      column :imported_at, :timestamp, null: false
    end
  end
end
