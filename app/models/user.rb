require 'digest/sha1'
class User < ActiveRecord::Base
  
  has_and_belongs_to_many :projects, :uniq => true
  has_many :tasks
  
  attr_accessor :supplied_password, :del_avatar
   
  
  before_save :create_hashed_password, :destroy_image?
  after_save :clear_password
 
  attr_accessible :first_name, :last_name, :username, :screen_name, :email, :title, :description, :level, :avatar
  attr_protected :password, :salt
  
  #before_post_process :rename_avatar
  
 # scope :named, lambda{ |usrnm| where(:username => usrnm)}
  scope :sorted, order("user.first_name ASC, user.last_name ASC")
  scope :not_involved_in, lambda { |project| { :conditions => ['id not in (?)', project.users.select(&:id).collect(&:id)] }}

  
  # For Paperclip
  has_attached_file :avatar, 
  :styles => { :medium => "250x250#", :small => "150x150#", :thumb => ["50x50#", :png], :tiny => ["30x30#", :png], :teeny => ["20x20#", :png] }, 
  :path => ":rails_root/public/:class/:attachment/:id_partition/:style/:filename",
  :url => "/:class/:attachment/:id_partition/:style/:filename",
  :default_url => "/users/avatars/default/:style.png",
  :convert_options => {
                     :thumb => Proc.new{self.convert_options(8)}, 
                                          :tiny => Proc.new{self.convert_options(4)},
                                          #:teeny => Proc.new{self.convert_options(2)}
                       # :thumb => Proc.new{self.convert_options_win(8)}, 
                       #                        :tiny => Proc.new{self.convert_options_win(4)},
                       #                        :teeny => Proc.new{self.convert_options_win(2)}
                      }
                      
                      
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
 
  validates :supplied_password, :presence => true, :length => {:within => 6..40}, :on => :create
  #validates :password, :confirmation => true, :length => {:within => 6..40}, :allow_blank => true, :on => :update

  validates :first_name, :presence => true, :length => { :maximum => 25 }
  validates :last_name, :presence => true, :length => { :maximum => 50  }
  validates :username, :presence => true, :uniqueness => true, :length => { :within => 3..25 }
  validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX
  
  # TODO : Look at adding :confirmation => true for email or password, where user has to enter them twice to check they match. 
  # for password change or email on sign up
  ### validates_confirmation_of :email, :message => "should match confirmation"  
  
  
  def name
    "#{first_name} #{last_name}"
  end  
  
  def self.convert_options(px = 10)
      trans = ""
      trans << " \\( +clone -alpha extract "
      trans << "-draw 'fill black polygon 0,0 0,#{px} #{px},0 fill white circle #{px},#{px} #{px},0' "
      trans << "\\( +clone -flip \\) -compose Multiply -composite "
      trans << "\\( +clone -flop \\) -compose Multiply -composite "
      trans << "\\) -alpha off -compose CopyOpacity -composite "
  end
    
  def self.convert_options_win(px = 10)
      trans = " "
      trans << " ( +clone -alpha extract -draw \"fill black polygon 0,0 0,#{px} #{px},0 fill white circle #{px},#{px} #{px},0 \"  "
      trans << " ( +clone -flip ) -compose Multiply -composite  "
      trans << " ( +clone -flop ) -compose Multiply -composite ) "
      trans << " -alpha off -compose CopyOpacity -composite  "
  end
  
  def self.make_salt(username="")
    Digest::SHA1.hexdigest("Salt #{username} at #{Time.now}")
  end
  
  def self.hash(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
  
  
  def del_avatar
    @del_avatar ||= "0"
  end

  def del_avatar=(value)
    @del_avatar = value
  end
  
  def self.authenticate(username="", password="")
     user = User.find_by_username(username)
     if user && user.password_match?(password)
       return user
     else
       return false
     end
  end
  
  def password_match?(pswd="")
    password == User.hash(pswd, salt)
  end
    
  def is_admin?
    level == 2
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

  def destroy_image?
    self.avatar.clear if @del_avatar == "1"
  end
  
  def rename_avatar
   # extension = File.extname(avatar_file_name).downcase
    #self.avatar.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
    puts 'nothing'
  end
    
    
  
end

