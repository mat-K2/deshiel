class EntriesController < ApplicationController
  def new
    @entry = current_user.entries.build
  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end

  def create
    @entry = current_user.entries.build(params[:entry])
    if @entry.save
      redirect_to user_path(current_user, {:type => params[:entry][:content_type]})
    else
      render action: "new"
    end
  end

  def update
    @entry = current_user.entries.find(params[:id])

    if @entry.update_attributes(params[:entry])
      redirect_to user_path(current_user, {:type => params[:entry][:content_type]})
    else
      render action: "edit"
    end
  end

  def destroy
    @entry = current_user.entries.find(params[:id])

    @entry.destroy
    redirect_to user_path(current_user, {:type => params[:content_type]})
  end

end
