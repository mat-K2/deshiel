class CreateEntryRelationships < ActiveRecord::Migration
  def change
    create_table :entry_relationships do |t|
      t.integer :entry_id
      t.integer :root_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
