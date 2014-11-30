class CreateMasterRelations < ActiveRecord::Migration
  def change
    create_table :master_relations do |t|
      t.integer :user_id
      t.integer :master_user_id

      t.timestamps
    end
  end
end
