class AddCommentReplyJoinTable < ActiveRecord::Migration
  
  def change
    create_table :comments_replies, :id => false do |t|
    t.integer  "comment_id"
    t.integer  "reply_id"
    t.timestamps
    end

    add_index :comments_replies, ["comment_id", "reply_id"]
  end


end
