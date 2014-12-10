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

  has_many :pupil_relations, class_name: 'MasterRelation', foreign_key: :master_id
  has_many :pupils, source: :user, through: :pupil_relations

  validates :name, presence: true

  MASTER_GENRE_LIST = ["料理、グルメ、レシピ", "エンターテインメント", "インターネット、PC、家電", "健康", "美容、ファッション", "ビジネス", "恋愛", "人間関係", "子育て", "マナー", "教養、学問", "スポーツ、アウトドア", "ギャンブル", "おしゃべり、雑談", "地域、旅行", "その他"]

  PUPIL_AVAILABLE_PERIOD = 7.day.freeze

  def become_pupil(master_id)
    master_user = User.find(master_id)
    relation = self.master_relations.build(master_id: master_user.id, due_at: Time.now + PUPIL_AVAILABLE_PERIOD, master_genre: master_user.master_genre)
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

  def pupil_due(master_id)
    master_relations.find{ |relation| relation.due_at >= Time.now && relation.master_id == master_id }.due_at.strftime("%Y/%m/%d %H:%M:%S")
  end

  def masters_to_rate
    masters.where("due_at < ? AND rating IS NULL", Time.now)
  end

  def total_rating(genre=nil)
    target_relations = if genre
                         rated_pupil_relations.where("master_genre == ?", genre)
                       else
                         rated_pupil_relations
                       end
    target_relations.inject(0) { |sum, relation| sum + relation.rating }
  end

  def rated_pupil_relations
    pupil_relations.where("rating IS NOT NULL")
  end

  def current_pupil
    self.pupils.where("due_at > ?", Time.now).first
  end

  def has_pupil?
    current_pupil.present?
  end

  def master_genre_with_rate
    master_genre.present? ? "#{master_genre}(#{total_rating(master_genre)})" : 'なし'
  end
end
