class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.int :task_id
      t.string :name

      t.timestamps
    end
  end
end
