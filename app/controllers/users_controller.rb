# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id] || current_user.id)
    @type = if params[:type]
              params[:type]
            else
              if current_user.home_default == 1
                User::QUESTION_TYPE[:m]
              else
                User::QUESTION_TYPE[:p]
              end
            end
    @questions = if @user != current_user
                   @user.answer_entries
                 else
                   if @type == User::QUESTION_TYPE[:m]
                     current_user.entries.questions
                   elsif @type == User::QUESTION_TYPE[:p]
                     current_user.pupil_questions
                   else
                     current_user.answer_entries
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

end
