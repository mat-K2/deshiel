class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :master_relations
  has_many :masters, through: :master_relations

  has_many :entries
  has_many :pupil_entries, class_name: 'Entry', foreign_key: :pupil_id
  has_many :master_entries, class_name: 'Entry', foreign_key: :master_id

  has_one :pupil_relation, class_name: 'MasterRelation', foreign_key: :master_id
  has_one :pupil, source: :user, through: :pupil_relation

  def become_pupil(master_id)
    relation = self.master_relations.build(master_id: master_id)
    relation.save
  end

  def master?(master)
    masters.include?(master)
  end

  def pupil_entries_by_master(master)
    pupil_entries.where(master_id: master.id)
  end

  def master_entries_by_pupil(pupil)
    master_entries.where(pupil_id: pupil.id)
  end
end
