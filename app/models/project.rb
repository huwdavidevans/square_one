class Project < ActiveRecord::Base
  attr_accessible :code, :deadline, :description, :name
  
  has_many :tasks
  has_and_belongs_to_many :users
  
end
