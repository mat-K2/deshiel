class PupilController < ApplicationController
  def home
  end

  def search
    @users = User.where("id != ? AND master_genre == ?", current_user.id, params['master_genre'])
  end

  def rate
    master_relation = current_user.master_relations.find_by_master_id(params[:master_id])
    if master_relation.update_attributes(rating_params)
      redirect_to pupil_home_path
    else
      render :home
    end
  end

  private

  def rating_params
    params.permit(:rating)
  end
end
