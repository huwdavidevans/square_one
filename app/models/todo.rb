class Todo < ActiveRecord::Base
  attr_accessible :complete, :description, :name, :todo_list_id
  
  belongs_to :todo_list
end