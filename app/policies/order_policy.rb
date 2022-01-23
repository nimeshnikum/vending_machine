class OrderPolicy < ApplicationPolicy
  def create?
    user.role?(:buyer)
  end
end
