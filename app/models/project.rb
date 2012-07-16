class Project < ActiveRecord::Base
  attr_accessible :code, :deadline, :description, :name
end
