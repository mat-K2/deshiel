class ThanksController < ApplicationController
  def create
    @thank = current_user.thanks.build(params[:thank])
    if @thank.save
      redirect_to user_path(current_user, {:type => params[:thank][:content_type]})
    else
      render action: 'user#show'
    end
  end

end
