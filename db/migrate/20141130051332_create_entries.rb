class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :description

      t.timestamps
    end
  end
end
