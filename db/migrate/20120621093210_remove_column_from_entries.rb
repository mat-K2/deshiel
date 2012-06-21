class RemoveColumnFromEntries < ActiveRecord::Migration
  def up
    remove_column :entries, :parent_id
    remove_column :entries, :root_id
  end

  def down
    add_column :entries, :parent_id, :integer
    add_column :entries, :root_id, :integer
  end
end
