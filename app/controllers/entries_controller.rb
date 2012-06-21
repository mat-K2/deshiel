class EntriesController < ApplicationController
  def index
    @entries = current_user.entries
  end

  def new
    @entry = current_user.entries.build
  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end

  def create
    @entry = current_user.entries.build(params[:entry])
    if @entry.save
      redirect_to entries_path
    else
      render action: "new"
    end
  end

  def update
    @entry = current_user.entries.find(params[:id])

    if @entry.update_attributes(params[:entry])
      redirect_to entries_path
    else
      render action: "edit"
    end
  end

  def destroy
    @entry = current_user.entries.find(params[:id])

    @entry.destroy
    redirect_to entries_path
  end

end
