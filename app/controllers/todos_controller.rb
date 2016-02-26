MyApp.before "/todos*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/lists/:id/todos" do
  @current_user = User.find_by_id(session[:user_id])
  @list = List.find_by_id(params[:id])
  @percentage_done = @list.percent_of_list_done
  @unfinished_todos = Todo.where({"list_id" => @list.id, "completed" => false})
  @completed_todos = Todo.where({"list_id" => @list.id, "completed" => true})

    
    if Todo.exists?(:completed => false, :list_id => @list.id) == false
    @unfinished_error = true
    end

    if Todo.exists?(:completed => true, :list_id => @list.id) == false
      @completed_error = true
    end
    erb :"/todos/view_todos"
end

MyApp.get "/lists/:id/todos/:todoid" do
      @list = List.find_by_id(params[:id])
      @todo = Todo.find_by_id(params[:todoid])
      @todo_user_info = @todo.get_user_info
      @created_by_info = @todo.get_created_by_user_info
      @updated_by_info = @todo.get_updated_by_user_info
      erb :"/todos/view_one_todo"
end

# MyApp.get "users/user/:id/lists/list/:id/todos" do
#   @current_user = User.find_by_id(session[:user_id])
#   @percentage_done =@current_user.percent_of_list_done
#    @list = List.find_by_id(params[:id])
#     if @current_user.get_unfinished_todos.empty? == true
#       @unfinished_error = true
#     else
#       @current_todos = @current_user.get_unfinished_todos
#     end

#     if @current_user.get_completed_todos.empty? == true
#       @completed_error = true
#     else
#       @completed_todos = @current_user.get_completed_todos
#     end
#     erb :"/todos/view_todo"
# end

MyApp.get "/lists/:id/todos/create" do
      @current_user = User.find_by_id(session[:user_id])
      @list = List.find_by_id(params[:id])
      @users = User.all
      erb :"/todos/create_todo"
end

  MyApp.post "/lists/:id/todos/create/confirmation" do
      @current_user = User.find_by_id(session[:user_id])
      @list = List.find_by_id(params[:id])
      @users = User.all
      @todo = Todo.new
      @todo.title = params[:new_title]
      @todo.description = params[:new_description]
      @todo.completed = false
      @todo.user_id = params[:create_user_selection]
      @todo.list_id = @list.id
      @todo.created_by = @current_user.id
      @todo.updated_by = @current_user.id

      if @todo.check_todo_title_is_valid == false
         @invalid_title_error = true
         erb :"/todos/create_todo"

      elsif Todo.exists?(:title => params[:new_title], :completed => false, :list_id => @list.id) == true
        @duplicate_title_error = true
        erb :"/todos/create_todo"
      else
        @todo.save
        redirect :"/lists/#{@list.id}/todos/create/confirmation/success"
      end
  end

MyApp.get "/lists/:id/todos/create/confirmation/success" do
  @current_user = User.find_by_id(session[:user_id])
  @list = List.find_by_id(params[:id])
  @users = User.all
  @todo_added_notice = true
  erb :"/todos/create_todo"
end

MyApp.get "/lists/:id/todos/:todoid/update" do
      @list = List.find_by_id(params[:id])
      @todo = Todo.find_by_id(params[:todoid])
      @users = User.all
      @current_user = User.find_by_id(session[:user_id])
      if @todo.completed ==true
        @completed_error = true
      end
        erb :"/todos/update_todo"
end

MyApp.post "/lists/:id/todos/:todoid/update/confirmation" do
      @current_user = User.find_by_id(session[:user_id])
      @list = List.find_by_id(params[:id])
      @users = User.all
      @todo = Todo.find_by_id(params[:todoid])
      @todo.title = params[:update_title]
      @todo.description = params[:update_description]
      @todo.user_id = params[:update_user_selection]
      @todo.updated_by = @current_user.id
      @todo.list_id = @list.id
      
      if Todo.where({"title" => @todo.title, "user_id" => @current_user.id, "completed" => false}).where.not("id" => @todo.id).length >= 1
        @duplicate_title_error = true
        erb :"/todos/update_todo"

      elsif @todo.check_todo_title_is_valid == false
         @invalid_title_error = true
         erb :"/todos/update_todo"
      else
        @todo.save
        redirect :"/lists/#{@list.id}/todos"
      end
end

MyApp.post "/lists/:id/todos/lock" do
      @current_user = User.find_by_id(session[:user_id])
      @list = List.find_by_id(params[:id])
        if params[:completed_checkbox] != nil
          @current_user.lock_batch_todos_for_user(params[:completed_checkbox])
          redirect :"/lists/#{@list.id}/todos"
        else
          redirect :"/lists/#{@list.id}/todos"
        end
end

MyApp.post "/lists/list/:id/todos/:todoid/delete"do
      @current_user = User.find_by_id(session[:user_id])
      @list = List.find_by_id(params[:id])
      @todo = Todo.find_by_id(params[:todoid])
 
      if @todo.completed == false
        @todo.delete
        redirect :"/lists/#{list.id}/todos"
      else
        erb :"/todos/deleted_error"
      end
end