class User < ActiveRecord::Base
  # RETURNS boolean if 
  def check_create_user_email_is_valid
    return self.email != "" ? true : "email"
  end

  def check_create_user_name_is_valid
    return self.name != "" ? true : "name"
  end

  def check_create_user_password_is_valid
    return self.password != "" ? true : "password"
  end


  def create_user_check_valid_action
    email = check_create_user_email_is_valid
    name =  check_create_user_name_is_valid
    password = check_create_user_password_is_valid
    message = []

    if name == "name"
      message << user_name_error
    end

    if email == "email"
      message << user_email_error
    end

    if password == "password"
      message << user_password_error
    end
    
    return message
  end


  def user_name_error
    return "Please include your name."
  end

  def user_email_error
    return "Please include your email."
  end

  def user_password_error
    return "Please include a password."
  end

end

