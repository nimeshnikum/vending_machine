class OrderProcessing < BaseService
  class InsufficientQuantityError < StandardError
    def message
      'Insufficient product quantity!'
    end
  end

  class InsufficientDepositError < StandardError
    def message
      'Insufficient deposit to purchase a product!'
    end
  end

  def initialize(user, params)
    @current_user = user
    build_object!(params)
  end

  def call
    validate_product_quantity!
    validate_user_deposit!
    ActiveRecord::Base.transaction { process! }
    object
  end

  private

  attr_reader :object, :current_user

  delegate :buyer, :product, to: :object

  def build_object!(params)
    @object = current_user.orders.build(params)
    @object.total_amount = product.cost * object.quantity
  end

  def validate_product_quantity!
    raise InsufficientQuantityError if object.quantity > product.quantity
  end

  def validate_user_deposit!
    raise InsufficientDepositError if object.total_amount > buyer.deposit
  end

  def process!
    object.save!
    callbacks!
  end

  def callbacks!
    buyer.decrement!(:deposit, object.total_amount)
    product.decrement!(:quantity, object.quantity)
  end
end
