ROM::SQL.migration do
  change do
    create_table(:cards) do
      primary_key(:id, :uuid)
    end
  end
end
