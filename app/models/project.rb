class Project < ActiveRecord::Base
  
  attr_accessible :code, :deadline, :description, :name, :project_type_id
  
  belongs_to :project_type 
      
  has_many :tasks
  has_and_belongs_to_many :users
  
  
  def total_work_days
    total = 0;    
    self.tasks.each do |t|
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
    
  end
  
  
  def work_days_spent
    
  end
  
  def type
    project_type ? project_type.name.downcase.underscore : 'generic'
  end
  
  def ribbonURL
    "assets/projects/bookmark_#{type}.png"    
  end
  
  
end
