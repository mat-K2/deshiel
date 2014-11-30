class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @master_relation = current_user.master_relations.build
  end
end
