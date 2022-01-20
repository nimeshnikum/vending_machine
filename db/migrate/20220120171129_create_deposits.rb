class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.integer :buyer_id
      t.integer :amount
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
