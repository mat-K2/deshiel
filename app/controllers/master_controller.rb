class MasterController < ApplicationController
  before_action :load_role

  def home
    @pupil = current_user.current_pupil
    @entry = Entry.new
    @pupil_relations_to_accept = current_user.pupil_relations_to_accept
  end

  private

  def load_role
    @role = 'master'
  end
end
