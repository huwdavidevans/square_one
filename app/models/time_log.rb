class TimeLog < ActiveRecord::Base
    
  belongs_to :user
  belongs_to :task
  has_one :comment


  before_validation :hours_to_minutes
  
  attr_accessor :supplied_minutes, :supplied_hours
  attr_accessible :user_id, :task_id, :comment_id, :time_minutes, :supplied_hours, :supplied_minutes
  

  validates :time_minutes, :numericality => {:greater_than => 0}
 
 
  private 
  
   def hours_to_minutes     
     self.time_minutes = supplied_minutes.to_i + (supplied_hours.to_i*60)
   end
   
end
