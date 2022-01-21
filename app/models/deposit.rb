class Deposit < ApplicationRecord
  DEPOSIT_OPTIONS = [5, 10, 20, 50, 100].freeze

  belongs_to :buyer, class_name: 'User'

  validates :amount, presence: true, numericality: { only_integer: true }
  validate :possible_amount

  scope :active, -> { where("deleted_at IS NULL") }

  def self.reset!(scope)
    scope.each { |d| d.soft_delete! }
  end

  def soft_delete!
    update(deleted_at: Time.current)
  end

  private

  def possible_amount
    unless DEPOSIT_OPTIONS.include?(amount)
      errors.add(:amount, "is invalid")
    end
  end
end
