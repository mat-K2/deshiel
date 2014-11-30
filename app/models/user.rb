class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :master_relations
  has_many :masters, through: :master_relations

  has_one :pupil_relation, class_name: 'MasterRelation', foreign_key: 'master_user_id'
  has_one :pupil, source: :user, through: :pupil_relation
end
