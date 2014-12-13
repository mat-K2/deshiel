class PupilController < ApplicationController
  before_action :load_role
  skip_before_filter :authenticate_user!, only: %w(search)

  def home
    @current_masters = current_user.current_masters
    @entry = Entry.new
  end

  def search
    @users = User.where("id != ? AND master_genre == ?", current_user.try(:id) || 0, params['master_genre'])
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

  def load_role
    @role = 'pupil'
  end
end
