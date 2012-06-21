class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :content
      t.integer :user_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
