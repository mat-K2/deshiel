class Entry < ActiveRecord::Base
  belongs_to :user

  has_many :entry_relationships
  accepts_nested_attributes_for :entry_relationships

  has_many :rootships, :class_name => 'EntryRelationship', :foreign_key => :root_id, :dependent => :destroy
  has_many :comments, :through => :rootships, :source => :entry

  scope :questions, includes(:entry_relationships).where("entry_relationships.parent_id IS ?", nil)

end
