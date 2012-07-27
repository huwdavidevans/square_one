class Project < ActiveRecord::Base
  attr_accessible :code, :deadline, :description, :name
  
  has_many :tasks
  has_and_belongs_to_many :users
  
  
  def total_work_days
    total = 0;    
    self.tasks.each do |t|
      total += t.work_days
    end
    return total
  end
  
end
