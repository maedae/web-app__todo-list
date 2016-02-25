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
    
    if @current_lists.empty? == true
      @unfinished_error = true
    elsif @completed_lists.empty? == true
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
  @list.edited_by = @current_user.id
  @list.completed = false

  if @list.check_list_title_is_valid == false
    @invalid_title_error = true
    erb :"/lists/create_list"
  else
    @todo.save
    erb :"/todos/create"
  end
end
