MyApp.get "/users/user/:id/todos" do
  if User.find_by_id(session[:user_id]) != nil
  @current_user = User.find_by_id(session[:user_id])

    if @current_user.get_unfinished_todos.empty? == true
      @unfinished_error = true
    else
      @current_todos = @current_user.get_unfinished_todos
    end

    if @current_user.get_completed_todos.empty? == true
      @completed_error = true
    else
      @completed_todos = @current_user.get_completed_todos
    end
    erb :"/todos/view_todo"
  else
    erb :"/logins/login"
  end
end
