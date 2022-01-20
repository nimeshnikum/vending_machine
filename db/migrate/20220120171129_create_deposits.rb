class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.references :buyer, null: false, foreign_key: true
      t.integer :amount
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
