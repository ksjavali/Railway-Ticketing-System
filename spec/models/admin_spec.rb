require 'rails_helper'
require 'spec_helper'
RSpec.describe Admin, type: :model do
  let(:admin) { FactoryBot.build(:admin) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(admin).to be_valid
    end

    it "is not valid without an email" do
      admin.email = nil
      expect(admin).not_to be_valid
    end

    it "is not valid with an invalid email format" do
      admin.email = "invalid_email"
      expect(admin).not_to be_valid
    end

    it "is not valid with a duplicate email" do
      FactoryBot.create(:admin, email: admin.email)
      expect(admin).not_to be_valid
    end

    it "is not valid without a name" do
      admin.name = nil
      expect(admin).not_to be_valid
    end

    it "is not valid without a password" do
      admin.password = nil
      expect(admin).not_to be_valid
    end

    it "is not valid with phone in wrong format" do
        admin.phone_number = 1234567
        expect(admin).not_to be_valid
    end

    it "is not valid with credit number in wrong format" do
        admin.credit_number = 1234567
        expect(admin).not_to be_valid
    end


  end
end