class Pupils::EntriesController < ApplicationController
  def index
    @pupil_questions = current_user.pupil_questions
  end
end
