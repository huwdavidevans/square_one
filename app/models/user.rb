require 'digest/sha1'
class User < ActiveRecord::Base
  
  attr_accessor :supplied_password
  
  before_save :create_hashed_password
  after_save :clear_password
 
  attr_accessible :first_name, :last_name, :username, :screen_name, :email, :title, :description, :level, :avatar
  attr_protected :password, :salt
  
  # For Paperclip
  has_attached_file :avatar, 
  :styles => { :medium => "250x250>", :small => "150x150>", :thumb => "50x50>" }, 
  :path => ":rails_root/public/:class/:attachment/:id_partition/:style/:filename",
  :url => "/:class/:attachment/:id_partition/:style/:filename"
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50  }
  validates :username, :presence => true, :uniqueness => true, :length => { :within => 3..25 }
  validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX
  # TODO : Look at addinf :confirmation => true for email or password, where user has to enter them twice to check they match. 
  # for password change or email on sign up
  ### validates_confirmation_of :email, :message => "should match confirmation"  
  
  
  
  
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Salt #{username} at #{Time.now}")
  end
  
  def self.hash(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
    
  private
    
  def create_hashed_password
    unless supplied_password.blank?
      self.salt = User.make_salt(username) if salt.blank?
      self.password = User.hash(supplied_password, salt)
    end
  end
     
  def clear_password
    self.supplied_password = nil
  end
  
end

