class SearchController < ApplicationController
  def index
    @entry = current_user.entries.build
    if params[:search_type] == "entry"
      @entries = Entry.thanked_objectives.select{ |entry| entry.content.include?(params[:entry_item])}
    elsif params[:search_type] == "master"
      @masters = User.where("id != ? AND master_genre = ?", current_user.id, params[:master_genre])
    end
  end

end
