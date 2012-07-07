require 'digest/sha1'
class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :username, :screen_name, :email, :title, :description, :level


  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Salt #{username} at #{Time.now}")
  end
  
  def self.hash(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
end

