
require 'rails_helper'

RSpec.describe Train, type: :model do
  describe 'associations' do
    it 'has many tickets' do
      association = described_class.reflect_on_association(:tickets)
      expect(association.options[:dependent]).to eq(:destroy)
      expect(association.macro).to eq(:has_many)
    end

    it 'has many reviews' do
      association = described_class.reflect_on_association(:reviews)
      expect(association.options[:dependent]).to eq(:destroy)
      expect(association.macro).to eq(:has_many)
    end
  end
end