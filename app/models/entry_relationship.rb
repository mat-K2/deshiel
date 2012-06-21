class EntryRelationship < ActiveRecord::Base
  belongs_to :entry
  accepts_nested_attributes_for :entry

  belongs_to :root, :class_name => 'Entry', :foreign_key => :root_id
end
