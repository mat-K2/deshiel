class CreateThanks < ActiveRecord::Migration
  def change
    create_table :thanks do |t|
      t.integer :user_id
      t.integer :entry_id

      t.timestamps
    end
  end
end
