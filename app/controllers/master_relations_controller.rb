class MasterRelationsController < ApplicationController
  before_action :load_master, only: %w(create)

  def create
    relation = current_user.master_relations.build(master_id: @master.id, due_at: Time.now + User::Pupil::PUPIL_AVAILABLE_PERIOD, master_genre: @master.master_genre)
    if relation.save
      redirect_to @master, notice: '弟子入りしました'
    else
      render 'users/show', object: User.find(master_id)
    end
  end

  private

  def load_master
    @master = User.find(master_id)
  end

  def master_id
    params[:master_relation][:master_id]
  end
end
