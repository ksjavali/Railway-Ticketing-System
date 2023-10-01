class Train < ApplicationRecord
    has_many :tickets, dependent: :destroy
    has_many :reviews, dependent: :destroy
end
