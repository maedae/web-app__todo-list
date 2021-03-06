class Todo < ActiveRecord::Base

   # RETURNS boolean if title column value String is not empty or not
  def check_todo_title_is_valid
    return self.title != "" ? true : false
  end

  # RETURNS String
  def todo_title_already_exists_error
    return "You currently have an open 'todo' task with this title."
  end

  # RETURNS String
  def todo_title_error
    return "Please add a title"
  end

  # RETURNS String
  def todo_completed_error
    return "This Todo task has already been completed and can no longer be edited"
  end

  # RETURNS User instance where todo user_id matches user id. 
  def get_user_info
    return User.find_by_id(self.user_id)
  end

  # RETURNS String containing user'ss name. User instance where todo user_id matches user id . 
  def get_user_name
    user_info = User.find_by_id(self.user_id)
    return user_info.name
  end

  # RETURNS User instance where todo updated_by matches user id. 
  def get_updated_by_user_info
    return User.find_by_id(self.updated_by)
  end

  # RETURNS User instance where todo updated_by matches user id. 
  def get_created_by_user_info
    return User.find_by_id(self.created_by)
  end

end