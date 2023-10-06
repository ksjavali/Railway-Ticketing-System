class Passenger < ApplicationRecord
    has_secure_password
    has_many :tickets, dependent: :destroy
    has_many :reviews, dependent: :destroy
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
    validates :password, presence: true, on: [new, create]
    validates :credit_number, numericality: { only_numeric: true }, length: {is: 16, message: "must be 16 digits"}
    validates :phone_number, length: {is: 10}
end
