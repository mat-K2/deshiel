class AddNullFalseValidationToTables < ActiveRecord::Migration
  def change
    change_column :users,            :name,        :string,  null: false
    change_column :master_relations, :user_id,     :integer, null: false
    change_column :master_relations, :master_id,   :integer, null: false
    change_column :entries,          :description, :string,  null: false
    change_column :entries,          :user_id,     :integer, null: false
    change_column :entries,          :master_id,   :integer, null: false
  end
end
