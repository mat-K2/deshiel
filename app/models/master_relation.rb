class MasterRelation < ActiveRecord::Base
  belongs_to :user
  belongs_to :master, class_name: 'User', foreign_key: :master_id
end
