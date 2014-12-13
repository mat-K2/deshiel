module User::Pupil
  extend ActiveSupport::Concern

  included do
    has_many :pupil_entries, class_name: 'Entry', foreign_key: :pupil_id
    has_many :master_relations
    has_many :masters, through: :master_relations
  end

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

  def pupil_due(master_id)
    master_relations.find{ |relation| relation.due_at >= Time.now && relation.master_id == master_id }.due_at.strftime("%Y/%m/%d %H:%M:%S")
  end

  def masters_to_rate
    masters.where("due_at < ? AND rating IS NULL", Time.now)
  end
end
