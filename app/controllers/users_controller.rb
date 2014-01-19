# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id] || current_user.id)
    @type = current_user.view_type_of_show_user(@user, params[:type])
    @objectives = current_user.get_objectives_of_show_user(@user, @type)
    @relation_user = current_user.get_relation_user_of_show_user(@user, @type)
    @relation_user_type = current_user.get_relation_user_type(@type)

    @entry = current_user.entries.build
    @entry.entry_relationships.build
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render action: "edit"
    end
  end

  def search
    @entry = current_user.entries.build
    if params[:search_type] == "entry"
      @entries = Entry.thanked_objectives.select{ |entry| entry.content.include?(params[:entry_item])}
    elsif params[:search_type] == "master"
      @masters = User.where("id != ? AND master_genre = ?", current_user.id, params[:master_genre])
    end
  end

  def history
    @user = current_user
    @achieved_objectives = current_user.achieved_objectives
    @get_thanked_objectives = current_user.get_thanked_objectives
  end
end
