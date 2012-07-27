class AlterTasksMetrics < ActiveRecord::Migration
 
  def up
    change_table :tasks do |t|
      t.boolean :complete, :default => false
      t.integer :work_minutes, :default => 438
    end
  end
 
 
 
  def down
    remove_column :tasks, :work_minutes
    remove_column :tasks, :complete
  end


end
