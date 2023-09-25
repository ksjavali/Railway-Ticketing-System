class Review < ApplicationRecord
    belongs_to :passenger
    belongs_to :trains
end
