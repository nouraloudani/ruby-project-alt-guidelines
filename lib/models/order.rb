class Order < ActiveRecord::Base

   belongs_to :user
   
   has_many :order_products
   has_many :products, through: :order_products

   # amount method, sum of all product prices within Order

end