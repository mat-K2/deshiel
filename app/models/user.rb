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

  MASTER_GENRE_LIST = ["料理、グルメ、レシピ", "エンターテインメント", "インターネット、PC、家電", "健康", "美容、ファッション", "ビジネス", "恋愛", "人間関係", "子育て", "マナー", "教養、学問", "スポーツ、アウトドア", "ギャンブル", "おしゃべり、雑談", "地域、旅行", "その他"]

  PUPIL_AVAILABLE_PERIOD = 7.day.freeze

  def become_pupil(master_id)
    relation = self.master_relations.build(master_id: master_id, due_at: Time.now + PUPIL_AVAILABLE_PERIOD)
    relation.save
  end

  def master?(master)
    current_masters.include?(master)
  end

  def current_masters
    masters.where("due_at >= ?", Time.now)
  end

  def pupil_entries_by_master(master)
    pupil_entries.where(master_id: master.id)
  end

  def master_entries_by_pupil(pupil)
    master_entries.where(pupil_id: pupil.id)
  end
end
