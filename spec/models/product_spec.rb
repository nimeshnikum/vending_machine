require "rails_helper"

RSpec.describe Product do
  describe 'associations' do
    it { should belong_to(:seller) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
    it { should allow_value(1, 10, 200).for(:quantity) }
    it { should_not allow_value(nil, -5, 0).for(:quantity) }
    it { should validate_presence_of(:cost) }
    it { should validate_numericality_of(:cost) }
    it { should allow_value(5, 10, 55).for(:cost) }
    it { should_not allow_value(nil, 3, -5, 0).for(:cost) }
  end
end
