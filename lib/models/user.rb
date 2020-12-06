class User < ActiveRecord::Base

   has_many :orders

   # def self.pending_orders
   #    orders.find_or_create_by(completed: false)
   # end

   # prompt user to choose something to do
   # def self.main_menu
      # puts "You have logged in, here are you pending orders:"
      
      # if no orders, puts "you currently have no pending orders"
      # list options
   # end

   def self.login_a_user
      puts "Please enter your username:"
      usern = gets.chomp
      puts "Please enter your password:"
      passw = gets.chomp
      user = User.find_by(username: usern, password: passw)
      if user.nil?
         puts "Please try again! Username or password could not be found!"
      else
         user
      end
   end

   # # prompt user to choose something to do
   # def main_menu
   #    puts "You have logged in, here are you pending orders:"
   #    pending_orders
   #    # if no orers, puts "you currently have no pending orders"
   #    # list options
   # end

   def past_orders
      orders.where(completed: true)
   end

   # def pending_orders
   #    orders.find_or_create_by(completed: false)
   # end

   def average_amount_per_order
      past_orders.sum(:amount)/past_orders.size
   end

   # def find_by_product(product)
   # def find_by_vendor(vendor)
   # def add_a_product
   # def remove_from_order_profuct
   # def amount_spent_per_vendor(vendor)
   # def update: find a product and replace it


end