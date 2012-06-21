class ThanksController < ApplicationController
  def create
    @thank = current_user.thanks.build(params[:thank])
    if @thank.save
      redirect_to entries_path
    else
      render action: 'entries#index'
    end
  end

end
