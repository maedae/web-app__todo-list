MyApp.before "/lists*" do 
    @current_user = User.find_by_id(session[:user_id])
    if @current_user == nil
        redirect :"/login"
    end
end

MyApp.get "/lists" do
  @current_user = User.find_by_id(session[:user_id])
  @current_lists = List.where({"completed" => false})
  @completed_lists = List.where({"completed" => true})
    
    if List.exists?(:completed => false) == false
      @unfinished_error = true
    end
   if List.exists?(:completed => true) == false
       @completed_error = true
    end
    erb :"/lists/view_all_lists"
end


MyApp.get "/lists/create" do
  erb :"/lists/create_list"
end

MyApp.post "/lists/create/confirm" do
  @current_user = User.find_by_id(session["user_id"])
  @list = List.new
  @list.title = params[:new_list_title]
  @list.created_by = @current_user.id
  @list.updated_by = @current_user.id
  @list.completed = false

  if List.where({"title" => @list.title, "completed" => false}).length >= 1
    @duplicate_title_error = true
    erb :"/lists/create_list"

  elsif @list.check_list_title_is_valid == false
    @invalid_title_error = true
    erb :"/lists/create_list"
  else
    @users = User.all
    @list.save
    erb :"/todos/create_todo"
  end
end

MyApp.get "/lists/:id/update" do
  @list = List.find_by_id(params[:id])
  erb :"/lists/update_list"
end

MyApp.post "/lists/:id/update/confirmation" do
  @current_user = User.find_by_id(session[:user_id])
  @list = List.find_by_id(params[:id])
  @list.title = params[:update_list_title]
  @list.created_by = @current_user.id
  @list.updated_by = @current_user.id
  @list.completed = false

  if List.where({"title" => @list.title, "completed" => false}).length >= 1
    @duplicate_title_error = true
    erb :"/lists/update_list"

  elsif @list.check_list_title_is_valid == false
    @invalid_title_error = true
    erb :"/lists/update_list"
  else
    @users = User.all
    @list.save
    redirect :"/lists/#{@list.id}/todos"
  end
end
