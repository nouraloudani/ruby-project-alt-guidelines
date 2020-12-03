class CreateTransactions < ActiveRecord::Migration[5.2]
  def change

    create_table :transactions do |t| 
      t.integer :user_id
      t.string :date
      t.integer :amount
      t.boolean :completed
    end
    
  end
end
