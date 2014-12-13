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

  private

  def load_role
    @role = 'pupil'
  end
end
