namespace :bootstrap do
  desc "Add the default user"
  task :default_user => :environment do
    u = User.new
    u.first_name = "Huw"
    u.last_name = "Evans"
    u.username = "evansh"
    u.screen_name = "Huw E"
    u.email = "huwdavidevans@gmail.com"
    u.title = "Portal Manager"
    u.description = ""
    u.level = 2
    u.active = true
    u.salt = User.make_salt(u.username)
    u.password = User.hash('ngfl1234', u.salt)
    u.save
  end

  desc "Add the user roles"
  task :default_user_roles => :environment do
    UserRole.create(:title => "user", :description => "Regular User")
    UserRole.create(:title => "admin", :description => "Admin User")
  end


  desc "Run all bootstrapping tasks"
  task :all => [:default_user, :default_user_roles]
end