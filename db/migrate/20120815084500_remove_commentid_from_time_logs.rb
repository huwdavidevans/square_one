class RemoveCommentidFromTimeLogs < ActiveRecord::Migration
  def up
    remove_column :time_logs, :comment_id
  end  
  def down
    add_column :time_logs, :comment_id, :integer
  end
end
