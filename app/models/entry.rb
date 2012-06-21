class Entry < ActiveRecord::Base
  belongs_to :user

  scope :questions, where("parent_id IS ?", nil)
end
