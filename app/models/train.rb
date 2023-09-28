class Train < ApplicationRecord
    has_many :passengers
    has_many :tickets
    has_many :reviews
end
