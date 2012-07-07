class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
            
      t.string "first_name", :limit => 50, :null => false
      t.string "last_name", :limit => 50, :null => false
      t.string "username", :limit => 25, :null => false
      t.string "screen_name", :limit => 50
      t.string "email", :limit => 100, :null => false
      t.string "title", :limit => 50
      t.text "description"
      t.integer "level", :default => 0
      t.boolean "active", :default => false
      
      t.string "password", :null => false
      t.string "salt", :null => false
      t.timestamps
      
    end
  end
end
