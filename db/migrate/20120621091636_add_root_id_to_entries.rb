class AddRootIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :root_id, :integer
  end
end
