class List < ActiveRecord::Base

 # RETURNS boolean if title column value String is not empty or not
  def check_list_title_is_valid
    return self.title != "" ? true : false
  end

  # RETURNS String
  def list_title_error
    return "Please add a title"
  end

  def list_title_already_exists_error
    return "There is already an open list with this title."
  end

  def percent_of_list_done
    total_todos = Todo.where({"list_id" => self.id}).length
    completed_todos = Todo.where({"list_id" => self.id, "completed" => true}).length

    if total_todos == nil
      total_todos = 0
    end

    if completed_todos == nil
      completed_todos = 0
    end

    todo_ratio = completed_todos.to_f / total_todos.to_f * 100
    return todo_ratio.round(2)
  end


  # Method checks if there are any open todos affliated with the list
  def check_if_open_todo_tasks_exist
    return Todo.exists?({:list_id => self.id, :completed => false}) ? true : false
    end

  # Method deletes all todo tasks for the list
  def delete_list_todos
    list = self.id
    Todo.where({"list_id" => list}).delete_all
  end

end