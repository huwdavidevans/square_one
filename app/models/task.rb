class Task < ActiveRecord::Base
  attr_accessible :deadline, :description, :name, :project_id, :user_id
end
