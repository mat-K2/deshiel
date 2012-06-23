class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :job, :string
    add_column :users, :master_genre, :string
    add_column :users, :web_site, :string
    add_column :users, :self_introduction, :string
  end
end
