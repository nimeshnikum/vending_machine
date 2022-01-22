class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :deposit
end
