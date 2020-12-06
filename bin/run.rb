require_relative '../config/environment'

application_instance = Application.new
application_instance.welcome

user_or_nil = application_instance.login_or_register

until user_or_nil
    user_or_nil = application_instance.login_or_register
end
