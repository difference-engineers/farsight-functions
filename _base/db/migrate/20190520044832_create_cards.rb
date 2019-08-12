ROM::SQL.migration do
  change do
    create_table(:cards) do
      column(:id, :uuid, :primary => true)
    end
  end
end
