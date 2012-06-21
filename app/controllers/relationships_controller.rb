class RelationshipsController < ApplicationController
  def create
    @relationship = current_user.relationships.build(:master_id => params[:relationship][:view_user_id])
    @relationship.save
    redirect_to user_path(params[:relationship][:view_user_id])
  end

  def destroy
    rel_id = Relationship.find_by_user_id_and_master_id(current_user.id, params[:view_user_id])
    @relationship = current_user.relationships.find(rel_id)
    @relationship.destroy
    redirect_to user_path(params[:view_user_id])
  end

end
