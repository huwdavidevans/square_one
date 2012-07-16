class Todo < ActiveRecord::Base
  attr_accessible :complete, :description, :name, :todo_list_id
end
