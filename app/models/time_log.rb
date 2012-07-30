class TimeLog < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  
  belongs_to :user
  belongs_to :task
  has_one :comment

  before_validation :hours_to_minutes
  
  attr_accessor :supplied_minutes, :supplied_hours
  attr_accessible :user_id, :task_id, :comment_id, :time_minutes, :supplied_hours, :supplied_minutes
  

  validates :time_minutes, :numericality => {:greater_than => 0}
 
 
  def time_string
    i_min = (time_minutes % 60).to_i
    i_hrs = (time_minutes / 60).to_i 
    str_min = pluralize(i_min, "Minute") if i_min > 0
    str_hrs = pluralize(i_hrs, "Hour") if i_hrs > 0
    return  "#{str_hrs} #{str_min}"
     
  end
 
  private 
  
   def hours_to_minutes     
     self.time_minutes = supplied_minutes.to_i + (supplied_hours.to_i*60)
   end
   
end
