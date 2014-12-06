class PupilController < ApplicationController
  def home
  end

  def search
    @users = User.where("id != ? AND master_genre == ?", current_user.id, params['master_genre'])
  end
end
