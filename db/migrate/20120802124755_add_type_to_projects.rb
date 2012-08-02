class AddTypeToProjects < ActiveRecord::Migration
  def change
     change_table :projects do |t|
     t.integer :project_type_id
    end
  end
end
