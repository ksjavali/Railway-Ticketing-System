class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :transaction_number
      t.string :credit_number
      t.integer :ticket_price
      t.string :address
      t.string :phone_number

      t.timestamps
    end
  end
end
