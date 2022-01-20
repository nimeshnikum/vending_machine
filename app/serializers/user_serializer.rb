class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :total_deposit

  def total_deposit
    object.deposits.active.map(&:amount).sum
  end
end
