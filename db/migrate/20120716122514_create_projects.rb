class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :deadline
      t.string :code

      t.timestamps
    end
  end
end
