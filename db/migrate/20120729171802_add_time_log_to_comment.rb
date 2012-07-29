class AddTimeLogToComment < ActiveRecord::Migration
 
  def change
      change_table :comments do |t|
        t.integer :time_log_id
      end
    end

end
