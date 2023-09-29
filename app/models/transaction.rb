class Transaction < ApplicationRecord
    belongs_to :passenger
    belongs_to :train
    validates :credit_number, presence: true, length: {is: 16}, numericality: { only_numeric: true }
    validates :address, presence: true
    validates :phone_number, presence: true, length: {is: 10}, numericality: { only_numeric: true }
    validates :ticket_price, presence: true
end
