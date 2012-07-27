class Task < ActiveRecord::Base
  
  attr_accessor :supplied_work_days  
  
  before_save :work_days_to_minutes
  after_save :clear_work_days
  
  belongs_to :project
  belongs_to :user
  has_many :todo_lists
  
  
  attr_accessible :deadline, :description, :name, :project_id, :user_id, :supplied_work_days  
 
  def work_days
    work_minutes / MINUTES_IN_WORK_DAY
  end
  
  private
  
  def work_days_to_minutes
    self.work_minutes = supplied_work_days.to_i * MINUTES_IN_WORK_DAY
  end
  
  def clear_work_days
     self.supplied_work_days = nil
  end
  
end

