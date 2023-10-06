require 'faker'

FactoryBot.define do
    factory :train do
      train_number { Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase }
      departure_station { Faker::Address.city }
      termination_station { Faker::Address.city }
      departure_date { Faker::Date.between(from: Date.today, to: 1.year.from_now) }
      departure_time { Faker::Time.between(from: DateTime.now, to: 1.day.from_now, format: :default) }
      arrival_date { departure_date + rand(1..5).days }
      arrival_time { Faker::Time.between(from: departure_time, to: arrival_date.end_of_day, format: :default) }
      ticket_price { Faker::Commerce.price(range: 10.0..200.0) }
      train_capacity { Faker::Number.between(from: 50, to: 300) }
      seats_left { Faker::Number.between(from: 10, to: train_capacity) }
      average_rating {"2.5"}
    end
  end