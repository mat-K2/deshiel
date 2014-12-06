class AddRatingToMasterRelations < ActiveRecord::Migration
  def change
    add_column :master_relations, :rating, :integer
  end
end
