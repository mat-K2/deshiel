class AddMasterGenreToMasterRelations < ActiveRecord::Migration
  def change
    add_column :master_relations, :master_genre, :string
    change_column :master_relations, :master_genre, :string, null: false
  end
end
