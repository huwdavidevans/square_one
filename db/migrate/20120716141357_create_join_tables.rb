class CreateJoinTables < ActiveRecord::Migration
  def change
    create_table :projects_users, :id => false do |t|
      t.references :project, :null => false
      t.references :user, :null => false
    end
    add_index :projects_users, ["project_id", "user_id"]
    
       
  end
  
end
