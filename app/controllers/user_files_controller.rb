class UserFilesController < ApplicationController

  def index
    @user_files = UserFile.by_user(current_user.id)
  end

  def new
    @user_file = UserFile.new
  end
 
  def show; end

  def create
    file_name = user_file_params[:file].try(:original_filename) || 'FileName'
    valid_columns = columns_params.to_h
    @user_file = UserFile.create(user_id: current_user.id, status: 0, information: 'On Hold', filename: file_name)
    @user_file.file.attach(user_file_params[:file])
    ImportContactsFromFile.init(@user_file.file, valid_columns)
  end

  private

  def user_file_params
    params.require(:user_file).permit(:file)
  end

  def columns_params
    params.require(:user_file)[:columns].permit!
  end
end
