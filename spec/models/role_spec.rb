require "rails_helper"

RSpec.describe Role do
  describe 'associations' do
    it { should have_many(:users) }
    it { should have_many(:role_assignments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
