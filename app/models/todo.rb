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

end