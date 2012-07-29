class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :task
  belongs_to :project
  belongs_to :time_log
  
  attr_accessible :user_id, :task_id, :project_id, :in_reply_to, :body
  
  def replies
    Comment.find_all_by_in_reply_to(id)
  end
  
    
end
