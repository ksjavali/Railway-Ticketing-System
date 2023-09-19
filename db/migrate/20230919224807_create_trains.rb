class CreateTrains < ActiveRecord::Migration[6.1]
  def change
    create_table :trains do |t|
      t.integer :train_number
      t.string :departure_station
      t.string :termination_station
      t.datetime :departure_date
      t.datetime :arrival_date
      t.datetime :departure_time
      t.datetime :arrival_time
      t.integer :ticket_price
      t.integer :seats_left

      t.timestamps
    end
  end
end
