class CreateChangeColomnNameTransactionIdToProductId < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_products, :transaction_id
    add_column :order_products, :order_id, :integer
  end
end
