class RemoveMasterGenreColumnOfUsers < ActiveRecord::Migration
  def up
    remove_column :users, :master_genre_tags
  end

  def down
    add_column :users, :master_genre_tags, :string
  end
end
