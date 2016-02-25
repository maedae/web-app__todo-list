class List < ActiveRecord::Base

 # RETURNS boolean if title column value String is not empty or not
  def check_list_title_is_valid
    return self.title != "" ? true : false
  end

  # RETURNS String
  def list_title_error
    return "Please add a title"
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
end