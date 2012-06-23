class UsersController < ApplicationController
  def show
    @user = User.find(params[:id] || current_user.id)
    @relationship = current_user.relationships.build
    @questions = if @user != current_user
                   @user.answer_entries
                 else
                   if params[:type] == "my_questions"
                     current_user.entries.questions
                   elsif params[:type] == "pupil_questions"
                     current_user.pupil_questions
                   else
                     current_user.answer_entries
                   end
                 end
    @entry = current_user.entries.build
    @entry.entry_relationships.build
    @thank = current_user.thanks.build
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
