class CreateTrains < ActiveRecord::Migration[6.1]
  def change
    create_table :trains do |t|
      t.integer :train_number
      t.string :departure_station
      t.string :termination_station
      t.date :departure_date
      t.time :departure_time
      t.date :arrival_date
      t.time :arrival_time
      t.integer :ticket_price
      t.integer :train_capacity
      t.integer :seats_left
      t.float :average_rating
      t.timestamps
    end
  end
end
