MyApp.get "/login" do
  erb :"/logins/login"
end

MyApp.post "/login/confirmation" do
  if User.find_by_email(:email => params[:email]) == nil
    @invlid_email = true
    erb :"/logins/login"
  else
  @current_user = User.find_by_email("email" => params[:email])
    if @current_user.password != params[:password]
      @invalid_email = true
      erb :"/logins/login"
    else
      session["user_id"] = @current_user.id
      redirect :"/users/user/#{session[:user_id]}"
    end
  end
end