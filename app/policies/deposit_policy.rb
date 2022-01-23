class DepositPolicy < ApplicationPolicy
  def create?
    user.role?(:buyer)
  end

  def reset?
    create?
  end
end
