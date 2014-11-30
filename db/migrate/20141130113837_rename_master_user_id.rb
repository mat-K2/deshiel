class RenameMasterUserId < ActiveRecord::Migration
  def change
    rename_column :entries, :master_user_id, :master_id
    rename_column :master_relations, :master_user_id, :master_id
  end
end
