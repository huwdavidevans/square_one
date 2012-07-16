class TodoList < ActiveRecord::Base
  attr_accessible :name, :task_id
  
  belongs_to :task
  has_many :todos
  
end
