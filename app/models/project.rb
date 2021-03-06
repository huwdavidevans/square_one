class Project < ActiveRecord::Base
  
  attr_accessible :code, :deadline, :description, :name, :project_type_id
  
  belongs_to :project_type 
      
  has_many :tasks
  has_and_belongs_to_many :users, :uniq => true
  
  
  validates :name, :presence => true, :length => { :minimum => 5 }
  validates :project_type_id, :presence => true
  validates :deadline, :presence => true
  
  def self.with_users(filtered_users)
   !filtered_users.empty? ? joins(:users).where('user_id IN (?)', filtered_users) : scoped 
  end
  
  def self.with_types(filtered_types)
   !filtered_types.empty? ? joins(:project_type).where('project_type_id IN (?)', filtered_types) : scoped 
  end
  
  def self.open
   where(:open => true)
  end
  
 def self.closed
    where(:open => false)
  end

  def self.complete
    where(:complete => true)
  end

  def self.incomplete
    where(:complete => false)
  end
  
  def work_days
    total = 0;    
    tasks.each do |t|
      total += t.work_days
    end
    return total
  end
  
  
  def length_of
    (deadline - created_at.to_date).to_i  
  end
  
  
  def days_from_start
    ((Date.today + 0.days) - created_at.to_date).to_i
  end
  
  
  def days_left
    (deadline - Date.today).to_i
  end
  
  
  def percent_of_time_left
    ((100 * (days_from_start.to_f / length_of.to_f) ).ceil.to_f )
  end
  
  
  def work_days_left
    work_days.to_f - work_days_spent
  end
  
  
  def work_days_spent
    total = 0
    tasks.each do |t|
      total += t.work_days_spent
    end
    total
    #sprintf("%.2f",  total.to_f / MINUTES_IN_WORK_DAY).to_f
  end
  
  def work_percent_spent
    work_days > 0 ? work_days_spent / work_days : 0
  end
  
  
  def overdue
    Date.today > deadline
  end
  
  
  def overrun
    work_days_spent > work_days
  end
  
  def work_days_over
    work_days_spent - work_days
  end
  
  
  def tasks_not_started
     total = 0
      tasks.each do |t|
        total +=1 unless t.started
      end
      total
  end

  
  def tasks_in_qa
     total = 0
       tasks.each do |t|
         total +=1 if t.in_qa
       end
       total
   end
  
  def tasks_in_progress
     total = 0
       tasks.each do |t|
         total +=1 if t.in_progress
       end
       total
   end
   
   def tasks_completed
     total = 0
       tasks.each do |t|
         total +=1 if t.complete
       end
       total
   end
  
  
  def percent_of_tasks_in_progress
   tasks_in_progress.to_f / tasks.length 
  end
  
  def percent_of_tasks_completed
    tasks_completed.to_f / tasks.length
  end
  
  def percent_of_tasks_not_started
     tasks_not_started.to_f / tasks.length
  end
  
  
  def tasks_overdue
    to = []
     tasks.each do |t|
       to << t if t.overdue
     end
     to
  end
  
  def tasks_overrun
    to = []
    tasks.each do |t|
       to << t if t.overrun
     end
     to
  end
  
  
  def type
    project_type ? project_type.name.downcase.underscore : 'generic'
  end
  
  def ribbonURL
    "assets/projects/bookmark_#{type}.png"    
  end
  
    
  def activity
    activityArray = []
    tasks.each do |task|  
      activityArray += task.activity
    end
    activityArray.sort_by(&:created_at).reverse!.group_by{ |a| a.created_at.to_date }
  end
  
  def add_user(attributes)
      @new_user = User.find_by_id(attributes[:id]) unless attributes[:id] == nil
      self.users << @new_user unless @new_user == nil
  end
  
  
end
