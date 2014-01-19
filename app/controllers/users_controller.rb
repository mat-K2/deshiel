# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id] || current_user.id)
    @type = if @user != current_user
              User::QUESTION_TYPE[:p_a]
            else
              if params[:type]
                params[:type]
              else
                if current_user.home_default == 1
                  User::QUESTION_TYPE[:m]
                else
                  User::QUESTION_TYPE[:p]
                end
              end
            end
    @objectives = if @user != current_user
                   @user.get_thanked_objectives
                 else
                   if @type == User::QUESTION_TYPE[:m]
                     current_user.unachieved_objectives
                   elsif @type == User::QUESTION_TYPE[:m_a]
                     current_user.achieved_objectives
                   elsif @type == User::QUESTION_TYPE[:p]
                     current_user.pupil_objectives
                   else
                     current_user.get_thanked_objectives
                   end
                 end
    @relation_user = if @type == User::QUESTION_TYPE[:m]
                       @user.master
                     elsif @type == User::QUESTION_TYPE[:p]
                       @user.pupil
                     else
                       nil
                     end
    @relation_user_type = if @type == User::QUESTION_TYPE[:m]
                            "師匠"
                          elsif @type == User::QUESTION_TYPE[:p]
                            "弟子"
                          else
                            nil
                          end
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
end
