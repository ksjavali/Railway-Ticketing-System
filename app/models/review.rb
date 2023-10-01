class Review < ApplicationRecord
    belongs_to :passenger
    belongs_to :train
    validates :rating, presence: true , numericality: {greater_than: 0, only_integer: true, less_than:6}
    validates :feedback, presence: true
end
