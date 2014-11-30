class MasterRelationsController < ApplicationController
  def create
    if current_user.become_pupil(master_user_id)
      redirect_to User.find(master_user_id), notice: '弟子入りしました'
    else
      render 'users/show', object: User.find(master_user_id)
    end
  end

  private

  def master_user_id
    params[:master_relation][:master_user_id]
  end
end
