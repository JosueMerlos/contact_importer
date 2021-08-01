class UserFilesController < ApplicationController
  def new
    @user_file = UserFile.new
  end
 
  def create
    @user_file = UserFile.create(user_id: current_user.id, status: 0, information: 'On Hold')
    @user_file.file.attach(user_file_params[:file])
    ImportContactsFromFile.init(@user_file.file)
  end

  private

  def user_file_params
    params.require(:user_file).permit(:file)
  end
end
