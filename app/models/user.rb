# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :job, :master_genre, :web_site, :self_introduction, :home_default

  has_many :entries

  has_one :relationship, :dependent => :destroy
  has_one :master , :through => :relationship

  has_one :pupilship, :class_name => 'Relationship', :foreign_key => :master_id, :dependent => :destroy
  has_one :pupil, :through => :pupilship, :source => :user

  has_many :thanks, :dependent => :destroy
  has_many :thanked_entries, :through => :thanks, :source => :entry

  has_many :get_thanks, :class_name => 'Thank', :foreign_key => :master_id, :dependent => :destroy
  has_many :answer_entries, :through => :get_thanks, :source => :entry

  JOB_LIST = ["営業、事務、企画系", "クリエイティブ系", "販売系", "美容、ファッション系", "専門職系（コンサルタント、金融、不動産）", "技術系（電気、電子、機械）", "技術系（建築、土木）", "技術系（ソフトウェア、ネットワーク）", "技術系（素材、食品、メディカル）", "その他"]

  MASTER_GENRE_LIST = ["料理、グルメ、レシピ", "エンターテインメント", "インターネット、PC、家電", "健康", "美容、ファッション", "ビジネス", "恋愛", "人間関係", "子育て", "マナー", "教養、学問", "スポーツ、アウトドア", "ギャンブル", "おしゃべり、雑談", "地域、旅行", "その他"]

  HOME_DEFAULT = [["自身の問題一覧", 1], ["弟子の問題一覧", 2]]

  QUESTION_TYPE = { :m => "my_questions", :p => "pupil_questions", :a => "answer_questions" }

  def my_master?(view_user)
    self.master == view_user
  end

  def pupil_questions
    if self.pupil
      target_questions = []
      self.pupil.open_questions.each do |question|
        target_questions << question
      end
      target_questions
    end
  end

  def open_questions
    thank_entry_ids = self.thanks.map(&:entry_id)
    if thank_entry_ids.present?
      self.entries.questions.where("entries.id NOT IN (?)", thank_entry_ids)
    else
      self.entries.questions
    end
  end

  def my_post?(comment)
    self.entries.include?(comment)
  end

  def answer_questions
    self.answer_entries.uniq
  end

end
