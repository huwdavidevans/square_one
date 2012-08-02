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
    u.supplied_password = 'ngfl1234'
    u.avatar = File.open("public/users/avatars/b.jpg")
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
    p.deadline = 30.days.from_now
    p.code = "ALICE"
    p.users = [User.find_by_username('evansh'), User.find_by_username('legendary')]    
    p.tasks << Task.new(:deadline => p.deadline, :description => 'Description for the white rabbit task', :name => 'Follow the White Rabbit', :project_id => p.id, :user_id => User.find_by_username('evansh').id )
    p.tasks << Task.new(:deadline => p.deadline, :description => 'Description for the tea party task', :name => 'Attend the Mad Hatter\'s Tea Party', :project_id => p.id, :user_id => User.find_by_username('evansh').id )
    p.tasks << Task.new(:deadline => p.deadline, :description => 'Don\'t bump your head', :name => 'Eat Me Drink Me', :project_id => p.id, :user_id => User.find_by_username('legendary').id) 
    p.save
    
    
    p = Project.new
    p.name = "A Princess of Mars"
    p.description = "A second and third door receded before me and slipped to one side as the first, before I reached a large inner chamber where I found food and drink set out upon a great stone table. A voice directed me to satisfy my hunger and to feed my calot, and while I was thus engaged my invisible host put me through a severe and searching cross-examination."
    p.deadline = DateTime.civil(2012, 8, 12)
    p.code = "Mars"
    p.users = [User.find_by_username('evansh'), User.find_by_username('goatkeeper')]
    p.save
    
    
    p = Project.new
    p.name = "The Wizard of Oz"
    p.description = "\"That's all right,\" said the Scarecrow. \"You are quite welcome to take my head off, as long as it will be a better one when you put it on again.\""
    p.deadline = DateTime.civil(2012, 8, 1)
    p.code = "OZ"
    p.users = [User.find_by_username('evansh'), User.find_by_username('legendary'), User.find_by_username('goatkeeper')]
    p.save
    
    
    
    p = Project.new
    p.name = "Moby Dick"
    p.description = "During the most violent shocks of the Typhoon, the man at the Pequod\'s jaw-bone tiller had several times been reelingly hurled to the deck by its spasmodic motions, even though preventer tackles had been attached to it - for they were slack - because some play to the tiller was indispensable."
    p.deadline = DateTime.civil(2012, 8, 17)
    p.code = "WHALE"
    p.users = [User.find_by_username('evansh'), User.find_by_username('legendary')]
    p.save
    
  end


  
  desc "Add extra Users"
  task :extra_users => :environment do
    u = User.new
    u.first_name = "Brian"
    u.last_name = "Goat"
    u.username = "goatkeeper" 
    u.screen_name = "Jimmy"
    u.email = "james@jj.com"
    u.title = "Test Account"
    u.description = "Pizza for tea!"
    u.level = 1
    u.active = true
    u.supplied_password = 'ngfl1234'
    u.avatar = File.open("public/users/avatars/g.jpg")
    u.save

    u = User.new
    u.first_name = "Fred"
    u.last_name = "Legendary"
    u.username = "legendary" 
    u.screen_name = "Ledge"
    u.email = "ault@ault.com"
    u.title = "Edge Editor"
    u.description = "wee waa woo waa"
    u.level = 1
    u.active = true
    u.supplied_password = 'ngfl1234'
    u.avatar = File.open("public/users/avatars/d.jpg")
    u.save
  end
  
  
  
  desc "Add inital Project Types"
  task :add_project_types => :environment do
    
    pt = ProjectType.new
    pt.name = "Generic"
    pt.save
    
    pt = ProjectType.new
    pt.name = "NGfL"
    pt.save
    
    pt = ProjectType.new
    pt.name = "WJEC"
    pt.save
    
    pt = ProjectType.new
    pt.name = "CiLT"
    pt.save
        
    pt = ProjectType.new
    pt.name = "CPD"
    pt.save
    
    pt = ProjectType.new
    pt.name = "DFES"
    pt.save
    
    
  end



  desc "Run all bootstrapping tasks"
  task :all => [:default_user_roles, :default_user, :extra_users, :add_test_projects, :add_project_types]
end