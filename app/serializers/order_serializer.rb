class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_amount, :balance_amount

  belongs_to :product
  belongs_to :buyer

  def balance_amount
    calculate_change object.buyer.deposit
  end

  private

  def calculate_change(amount)
    change_array = []
    possible_coins = User::DEPOSIT_OPTIONS.reverse

    while amount > 0 do
      current_coin = possible_coins.shift
      until current_coin > amount do
        change_array << current_coin
        amount -= current_coin
      end
    end
    change_array
  end
end
