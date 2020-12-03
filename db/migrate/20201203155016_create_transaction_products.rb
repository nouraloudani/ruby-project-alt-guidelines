class CreateTransactionProducts < ActiveRecord::Migration[5.2]
  def change

    create_table :transaction_products do |t|
      t.integer :transaction_id
      t.integer :product_id
    end
  end
end
