class AddUserColumnsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :user_id, :integer
    add_column :entries, :master_user_id, :integer
  end
end
