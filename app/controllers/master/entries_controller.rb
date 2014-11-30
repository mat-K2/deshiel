class Master::EntriesController < ApplicationController
  before_action :set_entry, only: %w(destroy)

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      redirect_to master_home_path, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @entry.destroy
    redirect_to master_home_path, notice: 'Entry was successfully destroyed.'
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:description, :master_id, :pupil_id)
  end
end
