class Task < ActiveRecord::Base
  
  attr_accessor :supplied_work_days  
  
  before_save :work_days_to_minutes
  after_save :clear_work_days
  
  belongs_to :project
  belongs_to :user
  has_many :todo_lists
  has_many :comments
  has_many :time_logs
  
  attr_accessible :deadline, :description, :name, :project_id, :user_id, :supplied_work_days, :complete
 
  scope :started, joins(:time_logs).uniq    
  scope :not_started, where("tasks.id NOT IN (SELECT task_id FROM time_logs)")
  scope :in_progress, started.where(:complete => false)
  scope :in_qa, scoped
  scope :completed, started.where(:complete => true)
  scope :overdue, where('tasks.deadline < ?', Date.today)
  scope :overrun, where('tasks.work_minutes <  (SELECT SUM(time_minutes) from time_logs where task_id = tasks.id) ')
  
#  scope :by_user, lambda {|userid| where(["tasks.user_id = #{userid}"])} 
 
  validates :name, :presence => true, :length => { :minimum => 5 }
  validates :deadline, :presence => true
  validates :project_id, :presence => true
  validates :user_id, :presence => true
  
  
  def self.by_user(user_id)
      if user_id.nil?
        scoped
      else
        where(:user_id => user_id)
      end
    end
 
  def work_days
    work_minutes / MINUTES_IN_WORK_DAY
  end
  
  def length_of
    deadline - created_at.to_date.to_i
  end
  
  def days_from_start
    ((Date.today + 0.days) - created_at.to_date).to_i
  end
  
  def days_left
    (deadline - Date.today).to_i
  end
  
  def percent_of_time_left
    sprintf("%.2f", (100 * (days_from_start.to_f / length_of.to_f) ).ceil.to_f , :precision => 2) 
  end
  
  def work_days_left
    (work_days - work_days_spent).to_f
  end
  
  def work_days_spent
    total = 0
    time_logs.each do |tl|
      total += tl.time_minutes
    end
    total.to_f / MINUTES_IN_WORK_DAY
  end
  
  def work_percent_spent
    work_days_spent / (work_days.nonzero? || 1)
  end
  
  def activity
    (comments + time_logs).sort_by(&:created_at).reverse!
  end
  
  def started
    time_logs.length > 0
  end

  def in_progress
    started && !complete
  end
  
  def in_qa
    false
    # TODO logic here 
  end
  
  def overdue
    Date.today > deadline
   end

   def overrun
     work_days_spent > work_days
   end
  

  def status   
   if complete
     str = "Completed"    
   elsif in_progress       
     str = "In Progress"
   elsif !started
     str = "Not Started"
   elsif in_qa
     str = "In QA"
   end
    str
  end

  
  
  private
  
  def work_days_to_minutes    
     self.work_minutes = supplied_work_days.to_i * MINUTES_IN_WORK_DAY if supplied_work_days
  end
  
  def clear_work_days
     self.supplied_work_days = nil
  end
  
  
  
  
  
end

