class AddMasterIdToThanks < ActiveRecord::Migration
  def change
    add_column :thanks, :master_id, :integer
  end
end
