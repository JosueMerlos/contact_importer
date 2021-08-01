class CreateUserFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_files do |t|
      t.integer :status, null: false, default: 0
      t.string :information, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
