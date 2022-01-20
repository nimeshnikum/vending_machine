class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :seller_id
      t.string :name
      t.integer :quantity
      t.integer :cost

      t.timestamps
    end
  end
end
