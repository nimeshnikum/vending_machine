class Product < ApplicationRecord
  belongs_to :seller, class_name: 'User'

  validates :name, presence: true, uniqueness: true
  validates :quantity, :cost, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  validate :cost_in_multiples_of_five

  private

  def cost_in_multiples_of_five
    return if cost.blank?
    errors.add(:cost, 'must be in multiples of 5') unless (cost % 5).zero?
  end
end
