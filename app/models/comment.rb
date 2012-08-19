class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :task
  belongs_to :project
  belongs_to :time_log
  
  has_many :replies_association, :class_name => "CommentReply"
  has_many :replies, :through => :replies_association, :source => :reply
 
  has_one :in_reply_to_association, :class_name => "CommentReply", :foreign_key => "reply_id"
  has_one :in_reply_to, :through => :in_reply_to_association, :source => :comment
  
  validates :user_id, :presence => true
  #validates :body, :presence => true, :length => { :minimum => 5, :message => "You must enter a comment." }
  #TODO validate from time_logs with before_create
  
  attr_accessible :user_id, :task_id, :project_id, :in_reply_to, :body
  
    
end
