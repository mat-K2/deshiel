class UsersController < ApplicationController
  before_action :set_user, only: %w(show edit update)
  before_action :parse_query, only: %w(search)

  skip_before_action :authenticate_user!, only: %w(show search)

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

  def search
    @users = User.search_master(@query)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :description, :master_genre_list)
  end

  def parse_query
    @query = params['master_genre_query'].split(/\s|,/).delete_if(&:empty?)
  end
end
