class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
            
      t.string "first_name", :limit => 50, :null => false
      t.string "last_name", :limit => 50, :null => false
      t.string "user_name", :limit => 25, :null => false
      t.string "screen_name", :limit => 50
      t.string "email", :limit => 100, :null => false
      t.string "title", :limit => 50
      t.text "description"
      t.integer "user_level", :default => 0
      
      t.timestamps
      
    end
  end
end
