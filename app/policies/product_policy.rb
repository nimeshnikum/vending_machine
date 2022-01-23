class ProductPolicy < ApplicationPolicy
  def create?
    user.role?(:seller)
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end
