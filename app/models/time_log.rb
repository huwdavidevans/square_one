class TimeLog < ActiveRecord::Base
    
  belongs_to :user
  belongs_to :task
  has_one :comment

  attr_accessible :user_id, :task_id, :comment_id, :time_minutes
   
  
   
end
