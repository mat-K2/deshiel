class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :entries

  has_many :relationships, :dependent => :destroy
  has_many :masters , :through => :relationships

  has_many :pupilships, :class_name => 'Relationship', :foreign_key => :master_id, :dependent => :destroy
  has_many :pupils, :through => :pupilships, :source => :user

  has_many :thanks, :dependent => :destroy
  has_many :thanked_entries, :through => :thanks, :source => :entry

  def my_master?(view_user)
    self.masters.include?(view_user)
  end

  def pupil_questions
    target_questions = []
    self.pupils.each do |pupil|
      pupil.entries.questions.each do |question|
        target_questions << question
      end
    end
    target_questions
  end

end
