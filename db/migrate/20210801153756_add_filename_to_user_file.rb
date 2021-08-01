class AddFilenameToUserFile < ActiveRecord::Migration[6.1]
  def change
    add_column :user_files, :filename, :string
  end
end
