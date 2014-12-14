class MasterRelationsController < ApplicationController
  before_action :load_master, only: %w(create)

  def create
    relation = current_user.master_relations.build(master_id: @master.id, master_genre_tags: @master.master_genre_tags)
    if relation.save
      redirect_to @master, notice: '弟子入り申請しました'
    else
      render 'users/show', object: User.find(master_id)
    end
  end

  def accept
    relation = current_user.pupil_relations.find(params[:id])
    if relation.accept
      redirect_to master_home_path, notice: '弟子入りを承認しました'
    else
      render 'master/home'
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
