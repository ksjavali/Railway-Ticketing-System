class AddKeysToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_reference :passengers, :train, null: false, foreign_key: true
  end
end
