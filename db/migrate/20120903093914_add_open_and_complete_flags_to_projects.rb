class AddOpenAndCompleteFlagsToProjects < ActiveRecord::Migration
  def change 
     add_column :projects, :complete, :boolean, :default => false
     add_column :projects, :open, :boolean, :default => true
  end
end
