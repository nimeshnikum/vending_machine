require "rails_helper"

RSpec.describe Order do
  describe 'associations' do
    it { should belong_to(:buyer) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
    it { should allow_value(1, 10, 200).for(:quantity) }
    it { should_not allow_value(nil, -5, 0).for(:quantity) }
  end
end
