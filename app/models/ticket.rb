class Ticket < ApplicationRecord
    # before_create :generate_confirmation_number
    belongs_to :passenger
    belongs_to :train

    # def generate_confirmation_number
    #     # Generate a random confirmation number using SecureRandom
    #     self.confirmation_number = SecureRandom.hex(4).upcase
    #   end
end
