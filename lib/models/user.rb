class User < ActiveRecord::Base

   has_many :orders

   

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

   # adding the registration helper
   def self.register_a_user 
      # have the user enter a username and a password 
      # User.create(username, password) 
      puts "Please enter a username:"
      usern = gets.chomp
      puts "Please enter a password:"
      passw = gets.chomp
      
      user = User.find_by(username: usern)

      if user 
         puts "Sorry, it seems like you are already registered. Please try to login."
      else
         User.create(username: usern, password: passw)
      end
   end

   # create an order
   def create_order
      puts "What product would you like to order today?"
      product_name = gets.chomp
      # Product.find_by(name: product_name) ### if exists use as argument
      # else puts "Sorry, that product is not avaialable"
      order_date = Time.now.to_s
      Order.create(user_id: self.id, date: order_date, amount: Product.find_by(name: product_name).price, completed: false)
      
      # use Order.last to create OrderProduct
      OrderProduct.create(product_id: Product.find_by(name: product_name).id, order_id: Order.last.id)
   end

   # updates 'completed' to true, saves and destroys associated OrderProduct
   def complete_order
      order = Order.find_by(completed: false)
      order.completed = true
      order.save
      op_to_cancel = OrderProduct.find_by(order_id: order.id)
      op_to_cancel.destroy
   end

   # destroy pending Order and associated OrderProduct
   def cancel_order
      order = Order.find_by(completed: false)
      order.destroy
      op_to_cancel = OrderProduct.find_by(order_id: order.id)
      op_to_cancel.destroy
   end

   # returns array of completed Orders
   def past_orders
      orders.where(completed: true)
   end

   # returns array of orders where attribute 'completed' = false
   def pending_order
      orders.where(completed: false)
   end
   
   # returns average amount spent on all completed Orders
   def average_amount_per_order
      past_orders.sum(:amount)/past_orders.size
   end

   def add_product_to_order #add product order with a new product id.
      puts "What product would you like to add?"
      input = gets.chomp
      product_inst = Product.find_by(name: input)
      product_inst_id = product_inst.id
      if self.pending_order.length > 0
         OrderProduct.create(product_id: product_inst_id, order_id: Order.where(completed: false).id)
      else
         Order.create(user_id: self.id, date: Time.now.to_s, amount: Product.find_by(name: input).price, completed: false)
         OrderProduct.create(product_id: product_inst_id, order_id: Order.last)
      end
   end

   def remove_product_from_order
   end
   
   
   
   ### stretch goals ###

   ## utilize vendor model ##
   ## utilize price model ##
   ## utilize amount ##


   # return amount spent with specific vendor
   def amount_spent_with_vendor(vendor)
   end


end