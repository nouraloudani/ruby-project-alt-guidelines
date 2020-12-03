class CreateChangeTransactionProductsToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    rename_table :transaction_products, :order_products
  end
end
