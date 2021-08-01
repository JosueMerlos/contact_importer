class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.date :date_of_birth, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.string :credit_card_digest, null: false
      t.string :franchise, null: false
      t.string :credit_card_last_digits, null: false
      t.string :email, null: false, index: { unique: true, name: 'unique_emails' }

      t.timestamps
    end
  end
end
