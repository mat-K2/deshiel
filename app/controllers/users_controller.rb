class UsersController < ApplicationController
  def show
    @user = User.find(params[:id] || current_user.id)
    @relationship = current_user.relationships.build
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render action: "edit"
    end
  end

end
