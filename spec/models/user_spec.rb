require "rails_helper"

RSpec.describe User do
  describe 'associations' do
    it { should have_many(:roles) }
    it { should have_many(:products) }
    it { should have_many(:orders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
  end
end
