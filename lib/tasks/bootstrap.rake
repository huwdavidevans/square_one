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
  
  
  desc "Add 5 Test Projects"
  task :add_test_projects => :environment do
    
    p = Project.new
    p.name = "Alice in Wonderland"
    p.description = "Just then her head struck against the roof of the hall: in fact she was now more than nine feet high, and she at once took up the little golden key and hurried off to the garden door.Poor Alice! It was as much as she could do, lying down on one side, to look through into the garden with one eye; but to get through was more hopeless than ever: she sat down and began to cry again."
    p.deadline = DateTime.civil(2012, 8, 24)
    p.code = "ALICE"
    p.users = [User.find(1)]
    p.save
    
    
    p = Project.new
    p.name = "A Princess of Mars"
    p.description = "A second and third door receded before me and slipped to one side as the first, before I reached a large inner chamber where I found food and drink set out upon a great stone table. A voice directed me to satisfy my hunger and to feed my calot, and while I was thus engaged my invisible host put me through a severe and searching cross-examination."
    p.deadline = DateTime.civil(2012, 8, 12)
    p.code = "Mars"
    p.users = [User.find(1)]
    p.save
    
    
    p = Project.new
    p.name = "The Wizard of Oz"
    p.description = "\"That's all right,\" said the Scarecrow. \"You are quite welcome to take my head off, as long as it will be a better one when you put it on again.\""
    p.deadline = DateTime.civil(2012, 8, 1)
    p.code = "OZ"
    p.users = [User.find(1)]
    p.save
    
    
    
    p = Project.new
    p.name = "Moby Dick"
    p.description = "During the most violent shocks of the Typhoon, the man at the Pequod\'s jaw-bone tiller had several times been reelingly hurled to the deck by its spasmodic motions, even though preventer tackles had been attached to it - for they were slack - because some play to the tiller was indispensable."
    p.deadline = DateTime.civil(2012, 8, 17)
    p.code = "WHALE"
    p.users = [User.find(1)]
    p.save
    
  end


  desc "Run all bootstrapping tasks"
  task :all => [:default_user, :default_user_roles, :add_test_projects]
end