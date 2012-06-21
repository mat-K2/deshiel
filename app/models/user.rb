class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :questions

  has_many :relationships, :dependent => :destroy
  has_many :masters , :through => :relationships

  has_many :pupilships, :class_name => 'Relationship', :foreign_key => :master_id, :dependent => :destroy
  has_many :pupils, :through => :pupilships, :source => :user

  def my_master?(view_user)
    self.masters.include?(view_user)
  end

end
