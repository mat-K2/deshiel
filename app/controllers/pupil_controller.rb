class PupilController < ApplicationController
  before_action :load_role
  skip_before_filter :authenticate_user!, only: %w(search)

  def home
    @current_masters = current_user.current_masters
    @master_candidates = current_user.master_candidates
    @entry = Entry.new
  end

  private

  def load_role
    @role = 'pupil'
  end
end
