class User < ActiveRecord::Base
  # RETURNS boolean if email value String is not empty or not
  def check_create_user_email_is_valid
    return self.email != "" ? true : false
  end

  # RETURNS boolean if name value String is not empty or not
  def check_create_user_name_is_valid
    return self.name != "" ? true : false
  end

  # RETURNS boolean if password value String is not empty or not
  def check_create_user_password_is_valid
    return self.password != "" ? true : false
  end

  # Method looks at boolean values from other methods to determine what sign up errors have appeared. 
  #Calls other methods if values are false
  #
  # email  - calls on pre-existing method. stores Boolean return value
  # name - calls on pre-existing method. stores Boolean return value
  # password - calls on pre-existing method. stores Boolean return value
  # message - empty Array. will store Strings via method return values when applicable
  # user_name_error - Method returns String value
  # user_email_error - Method returns String value
  # user_password_error -Method returns String value
  #
  # Returns Array containing 3 - 0 String elements, depending on Method algorithm outcome
  def create_user_check_valid_action
    email = check_create_user_email_is_valid
    name =  check_create_user_name_is_valid
    password = check_create_user_password_is_valid
    message = []

    if name == false
      message << user_name_error
    end

    if email == false
      message << user_email_error
    end

    if password == false
      message << user_password_error
    end
    
    return message
  end

  # RETURNS String
  def user_name_error
    return "Please include your name."
  end

  # RETURNS String
  def user_email_error
    return "Please include your email."
  end

  # RETURNS String
  def user_password_error
    return "Please include a password."
  end

end

