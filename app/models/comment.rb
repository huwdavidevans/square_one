class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :task
  belongs_to :project
  belongs_to :time_log
  
  has_many :replies_association, :class_name => "CommentReply"
  has_many :replies, :through => :replies_association, :source => :reply
 
  has_many :in_reply_to_association, :class_name => "CommentReply", :foreign_key => "reply_id"
  has_many :in_reply_to, :through => :in_reply_to_association, :source => :comment
  
  attr_accessible :user_id, :task_id, :project_id, :in_reply_to, :body
  
  
  
    
end
