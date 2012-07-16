class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.int :todo_list_id
      t.string :name
      t.text :description
      t.boolean :complete

      t.timestamps
    end
  end
end
