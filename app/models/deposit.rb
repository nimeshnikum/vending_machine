class Deposit < ApplicationRecord
  DEPOSIT_OPTIONS = [5, 10, 20, 50, 100].freeze

  belongs_to :buyer, class_name: 'User'

  validates :amount, presence: true, numericality: { only_integer: true }
  validate :possible_amount

  scope :active, -> { where("deleted_at IS NULL") }

  private

  def possible_amount
    unless DEPOSIT_OPTIONS.include?(amount)
      errors.add(:amount, "is invalid")
    end
  end
end
