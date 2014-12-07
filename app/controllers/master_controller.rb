class MasterController < ApplicationController
  def home
    @pupil = current_user.current_pupil
  end
end
