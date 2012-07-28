class CreateTimeLogs < ActiveRecord::Migration
  def change
    create_table :time_logs do |t|
      t.integer "task_id", :null => false
      t.integer "user_id"
      t.integer "comment_id"
      t.integer "time_minutes"
      t.timestamps
    end
  end
end
