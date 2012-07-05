class SearchController < ApplicationController
  def index
    if params[:search_type] == "entry"
      @entries = Entry.questions.select{ |entry| entry.content.include?(params[:entry_item])}
    elsif params[:search_type] == "master"
      @masters = User.where("master_genre = ?", params[:master_genre])
    end
  end

end
