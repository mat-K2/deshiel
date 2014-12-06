class AddDueAtToMasterRelations < ActiveRecord::Migration
  def change
    add_column :master_relations, :due_at, :datetime
  end
end
