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
         # main_menu --> right now only returning user if user exists
         user
      end
   end

   # create an order
   # need argument of product to create OrderProduct
   def create_order(order_date, product_name)
      Order.create(user_id: self.id, date: order_date, amount: Product.find_by(name: product_name).price, completed: false)
      
      # use Order.last to create OrderProduct
      OrderProduct.create(order_id: Order.last.id, product_id: Product.find_by(name: product_name).id)
   end

   # updates Order instance by changing attribute 'completed' to false
   # destroy corresponding OrderProduct using order_id to identify
   def confirm_order(order_id)
      order = Order.find(order_id)
      order.completed = true
      order.save
      op_to_cancel = OrderProduct.find_by(order_id: order_id)
      op_to_cancel.destroy
   end

   def find_order_by_id(orderid)
      Order.find(orderid)
   end

   # checks to see if Order.completed = false 
   # --> if true, puts "Order has already been completed."
   # --> if false, destroys Order and corresponding OrderProduct
   ##### STILL NOT COMPLETED #####
   def cancel_order(orderid)
      order = find_order_by_id(15)
      if order.completed = false
         order.destroy
      else
         puts "Order has already been completed."
      end
   end

   # returns array of orders where attribute 'completed' = true
   def past_orders
      orders.where(completed: true)
   end

   # returns array of orders where attribute 'completed' = false
   def pending_orders
      orders.where(completed: false)
   end

   # returns the average amount spent with specific Vendor
   def average_amount_per_order
      past_orders.sum(:amount)/past_orders.size
   end

   # def amount_spent_per_vendor(vendor)
   def amount_spent_with_vendor(vendor)
   end


end