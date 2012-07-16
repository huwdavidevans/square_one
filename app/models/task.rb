class Task < ActiveRecord::Base
  attr_accessible :deadline, :description, :name, :project_id, :todo_list_id, :user_id
end
