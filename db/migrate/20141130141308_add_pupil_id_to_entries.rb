class AddPupilIdToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :pupil_id, :integer
    change_column :entries, :pupil_id, :integer, null: false
  end

  def self.down
    remove_column :entries, :pupil_id
  end
end
