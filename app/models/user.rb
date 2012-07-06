class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_name, :screen_name, :email, :title, :description, :user_level

end
