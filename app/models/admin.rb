class Admin < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
    validates :password, presence: true, on: [new, create]
    validates :credit_number, numericality: { only_numeric: true }, length: {is: 16, message: "must be 16 digits"}
    validates :phone_number, length: {is: 10}

end
