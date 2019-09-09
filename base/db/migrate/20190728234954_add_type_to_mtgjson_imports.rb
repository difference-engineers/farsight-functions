ROM::SQL.migration do
  change do
    alter_table(:mtgjson_imports) do
      add_column(:type, :citext)
    end
  end
end
