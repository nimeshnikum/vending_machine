class DepositSerializer < ActiveModel::Serializer
  attributes :id, :amount

  belongs_to :buyer, class_name: 'User'
end
