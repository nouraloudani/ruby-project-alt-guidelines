class User < ActiveRecord::Base

   has_many :orders

   attr_accessor :po
   

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

   # updates 'completed' to true, saves and destroys associated OrderProduct
   def complete_order
      order = self.pending_order
      order.completed = true
      order.amount = @po.sum(:amount)
      order.date = Time.now.to_s
      order.save
   end

   # destroy pending Order and associated OrderProduct
   def cancel_order
      order = self.pending_order
      order.destroy
      op_to_cancel = order.order_products
      op_to_cancel.destroy_all
   end

   # returns array of completed Orders
   def past_orders
      @po = orders.where(completed: true)
      po.map do |order|
         puts "#{order.date} - $#{order.amount}"
      end
   end

   # returns order where attribute 'completed' = false, add in case there is none
   # ensures that there will be a pending order when method is run, if one does not exist - one will be created
   def pending_order
      order = orders.find_or_create_by(completed: false)
   end
   
   # returns average amount spent on all completed Orders
   def average_amount_per_order
      @po.sum(:amount)/past_orders.size
   end

   # add product order with a new product id
   def add_product_to_order
      self.pending_order
      puts "Please see below a list of our available products:"
      all_products = Product.all.map do |prod|
         puts prod.name
         prod.name
      end 
      puts "What product would you like to add?"
      prod_input = gets.chomp

      if all_products.include? prod_input
         product_inst = Product.find_by(name: prod_input)
         product_inst_id = product_inst.id
         OrderProduct.create(product_id: product_inst_id, order_id: self.pending_order.id)
         current_pending_order = self.pending_order

         if current_pending_order.amount == nil
            current_pending_order.amount = product_inst.price
         else 
            current_pending_order.amount += product_inst.price
         end

         puts "Product has been added"
         return true
      else
         puts "You mistyped, please try again."
         return false

      end
   end

   #removes a specific product from a pending product
   def remove_product_from_order
      # first prompt user with products
      puts "Your pending products:"

      # displaying products within order
      products = self.pending_order.order_products.map do |op|
         Product.where(id: op.product_id)
      end

      prod_name = products.map do |prod|
         prod[0].name
      end
      puts prod_name
      puts "Please enter the name of the product you wish to remove:"
      input = gets.chomp
      prod_instance = Product.find_by(name: input)
      prod_instance_id = prod_instance.id
      op_to_destroy = OrderProduct.find_by(product_id: prod_instance_id, order_id: pending_order.id)
      op_to_destroy.destroy
      puts "Product has been removed from your order!"

   end

end