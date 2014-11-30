class MasterController < ApplicationController
  def home
    @pupil = current_user.pupil
  end
end
