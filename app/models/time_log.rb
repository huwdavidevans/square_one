class TimeLog < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  
  belongs_to :user
  belongs_to :task
  has_one :comment

  before_validation :hours_to_minutes
  
  attr_accessor :supplied_minutes, :supplied_hours
  attr_accessible :user_id, :task_id, :time_minutes, :supplied_hours, :supplied_minutes  

  validates :time_minutes, :numericality => {:greater_than => 0, :message => "You must enter a time." } 
  validates :user_id, :presence => true 
  validates :comment, :presence => true
  
  
   
  def self.by_user(user_id)
      if user_id.nil?
        scoped
      else
        where(:user_id => user_id)
      end
  end
   
  def self.from_week(num = 0)
    where(:created_at => num.week.ago.to_date.beginning_of_week..num.week.ago.to_date.end_of_week)
     # where('created_at' > num.week.ago.to_date.beginning_of_week & 'created_at' < num.week.ago.to_date.end_of_week)    
  end  
  
  def body
    if comment
      comment.body
    else
      "No comment available"
    end 
  end
 
  def minutes_i
    (time_minutes % 60).to_i 
  end 
 
  def hours_i
    (time_minutes / 60).to_i 
  end  
 
  def time_string
    str_min = pluralize(minutes_i, "Minute") if minutes_i > 0
    str_hrs = pluralize(hours_i, "Hour") if hours_i > 0
    return  "#{str_hrs} #{str_min}"     
  end
 
  private 
  
   def hours_to_minutes     
     self.time_minutes = supplied_minutes.to_i + (supplied_hours.to_i*60)
   end
   
end
