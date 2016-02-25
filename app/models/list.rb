class List < ActiveRecord::Base

 # RETURNS boolean if title column value String is not empty or not
  def check_list_title_is_valid
    return self.title != "" ? true : false
  end

  # RETURNS String
  def list_title_error
    return "Please add a title"
  end


end