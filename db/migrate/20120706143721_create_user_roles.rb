class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string "title", :limit => 25
      t.string "description", :limit => 50
    end
  end
end
