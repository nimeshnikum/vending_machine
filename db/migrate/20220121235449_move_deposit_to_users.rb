class MoveDepositToUsers < ActiveRecord::Migration[6.1]
  def change
    drop_table :deposits

    add_column :users, :deposit, :integer
  end
end
