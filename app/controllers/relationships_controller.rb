class RelationshipsController < ApplicationController
  def create
    @relationship = current_user.build_relationship(:master_id => params[:relationship][:view_user_id])
    @relationship.save
    redirect_to user_path(params[:relationship][:view_user_id])
  end

  def destroy
    @relationship = current_user.relationship
    @relationship.destroy
    redirect_to user_path(params[:view_user_id])
  end

end
