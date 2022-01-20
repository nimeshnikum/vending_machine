class Deposit < ApplicationRecord
  DEPOSIT_OPTIONS = [5, 10, 20, 50, 100].freeze

  belongs_to :buyer, class_name: 'User'

  validates :amount, presence: true, numericality: { only_integer: true, inclusion: { in: DEPOSIT_OPTIONS } }
end
