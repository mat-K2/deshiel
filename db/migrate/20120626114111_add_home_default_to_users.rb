class AddHomeDefaultToUsers < ActiveRecord::Migration
  def change
    add_column :users, :home_default, :integer
  end
end
