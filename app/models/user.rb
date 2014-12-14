class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  validates :name, presence: true

  include User::Master
  include User::Pupil

  def self.search_master(master_genre_query)
    users = User.where("master_genre_tags LIKE ?", "%#{master_genre_query}%")
    users.sort{ |u| u.total_rating(master_genre_query) }.reverse
  end
end
