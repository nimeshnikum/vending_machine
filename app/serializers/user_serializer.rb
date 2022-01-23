class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :deposit

  has_many :roles
end
