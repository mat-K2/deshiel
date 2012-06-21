class Pupils::ThanksController < ApplicationController
  def create
    @thank = current_user.thanks.build(params[:thank])
    if @thank.save
      redirect_to pupils_entries_path
    else
      render action: 'pupils/entries#index'
    end
  end

end
