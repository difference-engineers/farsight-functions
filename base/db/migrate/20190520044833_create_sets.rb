ROM::SQL.migration do
  change do
    create_table(:sets) do
      column(:id, :uuid, :primary => true)
      column(:name, :text)
    end
  end
end
