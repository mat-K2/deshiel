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
  has_many :thanked_objectives, :through => :thanks, :source => :entry

  has_many :get_thanks, :class_name => 'Thank', :foreign_key => :master_id, :dependent => :destroy
  has_many :be_thanked_objectives, :through => :get_thanks, :source => :entry

  JOB_LIST = ["営業、事務、企画系", "クリエイティブ系", "販売系", "美容、ファッション系", "専門職系（コンサルタント、金融、不動産）", "技術系（電気、電子、機械）", "技術系（建築、土木）", "技術系（ソフトウェア、ネットワーク）", "技術系（素材、食品、メディカル）", "その他"]

  MASTER_GENRE_LIST = ["料理、グルメ、レシピ", "エンターテインメント", "インターネット、PC、家電", "健康", "美容、ファッション", "ビジネス", "恋愛", "人間関係", "子育て", "マナー", "教養、学問", "スポーツ、アウトドア", "ギャンブル", "おしゃべり、雑談", "地域、旅行", "その他"]

  HOME_DEFAULT = [["自身の目標一覧", 1], ["弟子の目標一覧", 2]]

  QUESTION_TYPE = { :m => "my_objectives", :m_a => "my_achieved_objectives", :p => "pupil_objectives", :p_a => "pupil_achieved_objectives" }

  def my_master?(view_user)
    self.master == view_user
  end

  def pupil_objectives
    if self.pupil
      target_objectives = []
      self.pupil.unachieved_objectives.each do |objective|
        target_objectives << objective
      end
      return target_objectives
    end
  end

  def unachieved_objectives
    thank_entry_ids = self.thanks.map(&:entry_id)
    if thank_entry_ids.present?
      self.entries.objectives.where("entries.id NOT IN (?)", thank_entry_ids)
    else
      self.entries.objectives
    end
  end

  def achieved_objectives
    thank_entry_ids = self.thanks.map(&:entry_id)
    self.entries.objectives.where("entries.id IN (?)", thank_entry_ids)
  end

  def my_post?(comment)
    self.entries.include?(comment)
  end

  def get_thanked_objectives
    self.be_thanked_objectives.uniq
  end

  def view_type_of_show_user(target_user, params_type)
    if self != target_user
      User::QUESTION_TYPE[:p_a]
    else
      if params_type
        params_type
      else
        if self.home_default == 1
          User::QUESTION_TYPE[:m]
        else
          User::QUESTION_TYPE[:p]
        end
      end
    end
  end

  def get_objectives_of_show_user(target_user, view_type)
    if self != target_user
      target_user.get_thanked_objectives
    else
      if view_type == User::QUESTION_TYPE[:m]
        self.unachieved_objectives
      else
        self.pupil_objectives
      end
    end
  end

  def get_relation_user_of_show_user(target_user, view_type)
    if view_type == User::QUESTION_TYPE[:m]
      target_user.master
    elsif view_type == User::QUESTION_TYPE[:p]
      target_user.pupil
    else
      nil
    end
  end

  def get_relation_user_type(view_type)
    if view_type == User::QUESTION_TYPE[:m]
      "師匠"
    elsif view_type == User::QUESTION_TYPE[:p]
      "弟子"
    else
      nil
    end
  end
end
