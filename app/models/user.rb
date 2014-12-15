class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  validates :name, presence: true

  include User::Master
  include User::Pupil

  acts_as_taggable
  acts_as_taggable_on :master_genres

  def self.search_master(master_genre_query)
    users = User.tagged_with(master_genre_query, :any => true)
    users.sort{ |u| u.total_rating(master_genre_query) }.reverse
  end
end
