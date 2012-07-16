class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :name
      t.text :description
      t.date :deadline

      t.timestamps
    end
  end
end
