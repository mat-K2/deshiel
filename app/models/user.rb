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
    User.all
  end
end
