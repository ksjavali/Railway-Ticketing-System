class AddKeyToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :passenger, null: false, foreign_key: true
    add_reference :transactions, :train, null: false, foreign_key: true
  end
end
