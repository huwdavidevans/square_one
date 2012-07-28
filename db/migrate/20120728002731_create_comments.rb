class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer "user_id"
      t.integer "task_id"
      t.integer "project_id"
      t.integer "in_reply_to"
      t.text "body"
      t.timestamps
    end
  end
end
