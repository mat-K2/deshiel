class UsersController < ApplicationController
  before_action :set_user, only: %w(show edit update)

  skip_before_action :authenticate_user!, only: %w(show)

  def show
    if user_signed_in?
      @master_relation = current_user.master_relations.build
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: 'User was successfully updated'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :description, :master_genre)
  end
end
