class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.int :project_id
      t.int :user_id
      t.string :name
      t.text :description
      t.date :deadline
      t.int :todo_list_id

      t.timestamps
    end
  end
end
