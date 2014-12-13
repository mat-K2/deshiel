module User::Master
  extend ActiveSupport::Concern

  included do
    has_many :entries_as_master, class_name: 'Entry', foreign_key: :master_id
    has_many :pupil_relations, class_name: 'MasterRelation', foreign_key: :master_id
    has_many :pupils, source: :user, through: :pupil_relations
  end

  MASTER_GENRE_LIST = ["料理、グルメ、レシピ", "エンターテインメント", "インターネット、PC、家電", "健康", "美容、ファッション", "ビジネス", "恋愛", "人間関係", "子育て", "マナー", "教養、学問", "スポーツ、アウトドア", "ギャンブル", "おしゃべり、雑談", "地域、旅行", "その他"]

  def entries_by_pupil(pupil)
    entries_as_master.where(pupil_id: pupil.id)
  end

  def rated_pupil_relations
    pupil_relations.where("rating IS NOT NULL")
  end

  def total_rating(genre=nil)
    target_relations = if genre
                         rated_pupil_relations.where("master_genre == ?", genre)
                       else
                         rated_pupil_relations
                       end
    target_relations.inject(0) { |sum, relation| sum + relation.rating }
  end

  def current_pupil
    pupils.where("due_at > ?", Time.now).first
  end

  def has_pupil?
    current_pupil.present?
  end

  def master_genre_with_rate
    master_genre.present? ? "#{master_genre}(#{total_rating(master_genre)})" : 'なし'
  end

  def pupil_relations_to_accept
    pupil_relations.where(due_at: nil)
  end
end
