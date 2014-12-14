class ChangeNameOfMasterGenre < ActiveRecord::Migration
  def change
    rename_column :users, :master_genre, :master_genre_tags
    rename_column :master_relations, :master_genre, :master_genre_tags
  end
end
