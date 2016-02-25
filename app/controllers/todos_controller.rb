MyApp.get "/users/user/:id/todos" do
  if User.find_by_id(session[:user_id]) != nil
  @current_user = User.find_by_id(session[:user_id])
  @percentage_done =@current_user.percent_of_list_done
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
    redirect :"/login"
  end
end

MyApp.get "/users/user/:id/todos/create" do
    if User.find_by_id(session[:user_id]) == nil
      redirect :"/login"
    else
      @current_user = User.find_by_id(session[:user_id])
      erb :"/todos/create_todo"
    end
end

  MyApp.post "/users/user/:id/todos/create/confirmation" do
    if User.find_by_id(session[:user_id]) != nil
      @current_user = User.find_by_id(session[:user_id])
      @todo = Todo.new
      @todo.title = params[:new_title]
      @todo.description = params[:new_description]
      @todo.completed = false
      @todo.user_id = @current_user.id

      if @todo.check_todo_title_is_valid == false
         @invalid_title_error = true
         erb :"/todos/create_todo"

      elsif Todo.exists?(:title => params[:new_title], :completed => false, :user_id => @current_user.id) == true
        @duplicate_title_error = true
        erb :"/todos/create_todo"
      else
        @todo.save
        redirect :"/users/user/#{session[:user_id]}/todos"
      end
    else
      redirect :"/login"
    end
  end

MyApp.get "/users/user/:id/todos/:id/edit" do
    if User.find_by_id(session[:user_id]) == nil
      redirect :"/login"
    else
      @current_user = User.find_by_id(session[:user_id])
      @todo = Todo.find_by_id(params[:id])
      if @todo.completed ==true
        @completed_error = true
      end
        erb :"/todos/update_todo"
    end
end

MyApp.post "/users/user/:id/todos/:id/update/confirmation" do
    if User.find_by_id(session[:user_id]) != nil
      @current_user = User.find_by_id(session[:user_id])
      @todo = Todo.find_by_id(params[:id])
      @todo.title = params[:update_title]
      @todo.description = params[:update_description]
      
      if Todo.where({"title" => @todo.title, "user_id" => @current_user.id, "completed" => false}).where.not("id" => @todo.id).length >= 1
        @duplicate_title_error = true
        erb :"/todos/update_todo"

      elsif @todo.check_todo_title_is_valid == false
         @invalid_title_error = true
         erb :"/todos/update_todo"
      else
        @todo.save
        redirect :"/users/user/#{session[:user_id]}/todos"
      end
    else
      redirect :"/login"
    end
end

MyApp.post "/users/user/:id/todos/lock" do
    if User.find_by_id(session[:user_id]) != nil
      @current_user = User.find_by_id(session[:user_id])
        if params[:completed_checkbox] != nil
          @current_user.lock_batch_todos_for_user(params[:completed_checkbox])
          redirect :"/users/user/#{session[:user_id]}/todos"
        else
          redirect :"/users/user/#{@curren_user.id}/todos"
        end
    else
      redirect :"/login"
    end
end

MyApp.post "/users/user/:id/todos/:id/delete"do
    if User.find_by_id(session[:user_id]) != nil
      @current_user = User.find_by_id(session[:user_id])
      @todo = Todo.find_by_id(params[:id])
 
      if @todo.completed == false
        @todo.delete
        redirect :"/users/user/#{session[:user_id]}/todos"
      else
        erb :"/todos/deleted_error"
      end
    else
      redirect :"/login"
    end
end