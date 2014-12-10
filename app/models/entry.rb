class Entry < ActiveRecord::Base
  belongs_to :user

  validates :description, :user_id, :master_id, :pupil_id, presence: true
end
