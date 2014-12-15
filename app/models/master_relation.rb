class MasterRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :master, class_name: 'User', foreign_key: :master_id

  validates :user_id, :master_id, presence: true

  PUPIL_AVAILABLE_PERIOD = 7.day.freeze

  def accept
    self.due_at = Time.now + PUPIL_AVAILABLE_PERIOD
    self.save
  end
end
