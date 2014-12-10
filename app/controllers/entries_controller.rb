class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  def create
    @entry = current_user.entries.build(entry_params)

    if @entry.save
      redirect_to redirect_path_after_action, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to redirect_path_after_action, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:description, :master_id, :pupil_id)
    end

    def redirect_path_after_action
      case params[:role]
      when 'pupil'
        pupil_home_path
      when 'master'
        master_home_path
      end
    end
end
