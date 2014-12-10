class MasterController < ApplicationController
  before_action :load_role

  def home
    @pupil = current_user.current_pupil
    @entry = Entry.new
  end

  private

  def load_role
    @role = 'master'
  end
end
