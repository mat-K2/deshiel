class MasterRelationsController < ApplicationController
  def create
    if current_user.become_pupil(master_id)
      redirect_to User.find(master_id), notice: '弟子入りしました'
    else
      render 'users/show', object: User.find(master_id)
    end
  end

  private

  def master_id
    params[:master_relation][:master_id]
  end
end
