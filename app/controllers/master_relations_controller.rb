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

  def rate
    master_relation = current_user.master_relations_to_rate.find(params[:id])
    if master_relation.update_attributes(rating_params)
      redirect_to pupil_home_path
    else
      render :home
    end
  end

  private

  def load_master
    @master = User.find(master_id)
  end

  def master_id
    params[:master_relation][:master_id]
  end

  def rating_params
    params.require(:master_relation).permit(:rating)
  end
end
