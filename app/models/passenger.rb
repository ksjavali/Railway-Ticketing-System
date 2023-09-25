class Passenger < ApplicationRecord
    has_secure_password
    has_many :tickets
    has_many :reviews
    has_many_and_belongs_to_many :trains
    validates :email, presence: true, uniqueness: true

end
