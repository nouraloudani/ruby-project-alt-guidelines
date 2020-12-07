class Application

    attr_reader :prompt
    attr_accessor :user

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "Hello, Welcome to SmartOps!" 
    end

    def login_or_register
        prompt.select("Would you like to register or login?") do |menu|
            menu.choice "Register", -> {register_helper()}
            menu.choice "Login", -> {login_helper()}
        end
    end

    def login_helper
        User.login_a_user
    end

    #added register helper and link it to the user's class method
    def register_helper
        User.register_a_user 
    end

    def pending_orders
        orders.find_or_create_by(completed: false)
    end

    def main_menu
        user.reload
        
        system 'clear'

        prompt.select("Welcome, #{user.username}! What would you like to do?") do |menu|
            # create order (create)
            menu.choice "Create an order", -> {add_order}
            # view orders (read)
            menu.choice "View past orders", -> {past}
            menu.choice "View pending order", -> {pending}
            menu.choice "View average order amount", -> {average}
            # update order (update) : add/remove products
            menu.choice "Add product", -> {add_product}
            menu.choice "Remove product", -> {remove_product}
            menu.choice "Exit", -> {exit_app}
        end
    end

    # creates an order for the specific item entered by the user
    def add_order
        user.create_order
        main_menu
    end

    # returns array of orders where attribute 'completed' = true
    def past
        puts user.past_orders
        sleep 5
        main_menu
    end

    # returns array of orders where attribute 'completed' = false
    def pending
        puts user.pending_order
        
        if user.pending_order.length > 0
            prompt.select("Place your order?") do |menu|
                menu.choice "Complete", -> {complete}
                # remove order (destroy)
                menu.choice "Cancel", -> {cancel}
                menu.choice "Main menu", -> {main_menu}
            end
        else
            puts "You currently have no pending orders."
            sleep 5
            main_menu
        end

    end

    # puts the average amount spent with specific Vendor
    def average
        puts user.average_amount_per_order  
        sleep 5
        main_menu
    end

    def exit_app
        puts "See you next time!"
    end

    def complete
        user.complete_order
        puts "Your order has been placed!"
        sleep 7
        main_menu
    end

    def cancel
        user.cancel_order
        puts "Your order has been canceled!"
        sleep 7
        main_menu
    end

    def add_product
        user.add_product_to_order
        puts "Product has been added"
        sleep 5
        main_menu
    end


    def remove_product
        user.remove_product_from_order
    end



end