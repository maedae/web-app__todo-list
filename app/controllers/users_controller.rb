# controller used for the creation of a new user.
# page contains new user form. 
MyApp.get "/sign_up" do
  erb :"/users/create_user"
end

# handles form data sent from "/users/create"
MyApp.post "/sign_up/confirmation" do
  @new_user = User.new
  @new_user.name = params[:name]
  @new_user.email = params[:email]
  @new_user.password = params[:password]

  @error_check = @new_user.create_user_check_valid_action

  # checks to see if error array value is empty.
  # If variable is not empty, error flag is set and user is redirect back to create page.
  
  if @error_check.empty? == false
    @error = true
    erb :"/users/create_user"

  # Next, it will check to see if the user email selected already exists. 
  # If it does, error flag is set && user is directed to the create page with a different message.
  elsif User.exists?(:email => params[:email]) == true
    @matching_user_error = true 
    erb :"/users/create_user"

  # If neither of the aformentioned scenarios occur, user if directed to customized home page
  else
    @new_user.save
    session[:user_id] = @new_user.id  
    redirect :"/users/user/#{session[:user_id]}"
  end
end

MyApp.get "/users/user/:id" do
  @user = User.find_by_id(session[:user_id])
  erb :"/users/view_user"
end
