class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :master_relations
  has_many :masters, through: :master_relations

  has_one :pupil_relation, class_name: 'MasterRelation', foreign_key: 'master_user_id'
  has_one :pupil, source: :user, through: :pupil_relation

  def become_pupil(master_user_id)
    relation = self.master_relations.build(master_user_id: master_user_id)
    relation.save
  end

  def master?(master_user)
    masters.include?(master_user)
  end
end
