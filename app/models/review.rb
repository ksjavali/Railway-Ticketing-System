class Review < ApplicationRecord
    belongs_to :passenger
    belongs_to :trains
    validates :rating, presence: true , numericality: {greater_than: 0, only_integer: true, less_than:6}
    validates :review, presence: true
end
