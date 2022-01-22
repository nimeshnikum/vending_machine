class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :product

  validates :quantity, presence: true,
                       numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
