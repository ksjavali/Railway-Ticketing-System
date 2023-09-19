class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :password
      t.integer :phone_number
      t.string :address
      t.integer :credit_card

      t.timestamps
    end
  end
end
