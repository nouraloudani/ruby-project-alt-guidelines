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

    def register_helper
        puts "You have chosen register"
    end

    def pending_orders
        orders.find_or_create_by(completed: false)
    end

    # def main_menu
        # puts "You have logged in, here are you pending orders:"
        
        # if no orders, puts "you currently have no pending orders"
        # list options
            # "would you like to update or change and order?"
            # "would you like to see your transaction history?"
            # "would you like to see an overall business analysis"
    #  end

end