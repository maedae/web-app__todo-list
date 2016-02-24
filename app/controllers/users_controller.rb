# controller used for the creation of a new user.
# page contains new user form. 
MyApp.get "/users/create" do
  erb :"/users/create_user"
end

MyApp.post "/users/create/confirmation" do
  @new_user = User.new
  @new_user.name = params[:name]
  @new_user.email = params[:email]
  @new_user.password = params[:password]

  @error_check = @new_user.create_user_check_valid_action

  # checks to see if error array value is empty. If it is, they are sent to a customized welcome page. If it isn't
  # user is sent back to the creation page and will see customized error message instructions.
  if @error_check.empty? == true
    @new_user.save
    session[:user_id] = @new_user.id  
    erb :"/main"
  else
    @error = true
    erb :"/users/create_user"
  end

end