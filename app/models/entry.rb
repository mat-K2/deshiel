class Entry < ActiveRecord::Base
  belongs_to :user

  has_many :entry_relationships
  accepts_nested_attributes_for :entry_relationships

  has_one :childship, :class_name => 'EntryRelationship', :foreign_key => :parent_id
  has_one :child, :through => :childship, :source => :entry

  has_many :rootships, :class_name => 'EntryRelationship', :foreign_key => :root_id
  has_many :comments, :through => :rootships, :source => :entry

  scope :questions, includes(:entry_relationships).where("entry_relationships.parent_id IS ?", nil)

  attr_accessor :content_type

  def have_child?
    self.child.present?
  end
end
