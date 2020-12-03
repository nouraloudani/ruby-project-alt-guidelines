class CreateChangeTransactionsTableToOrders < ActiveRecord::Migration[5.2]
  def change
    rename_table :transactions, :orders
  end
end
