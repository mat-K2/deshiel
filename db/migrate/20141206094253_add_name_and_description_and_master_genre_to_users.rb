class AddNameAndDescriptionAndMasterGenreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name,         :string
    add_column :users, :description,  :string
    add_column :users, :master_genre, :string
  end
end
