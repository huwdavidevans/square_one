class Task < ActiveRecord::Base
  
  attr_accessible :deadline, :description, :name, :project_id, :user_id
  
  belongs_to :project
  belongs_to :user
  has_many :todo_lists
  
end
