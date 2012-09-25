ranamespace :bootstrap do
  
   desc "Add the user roles"
  task :default_user_roles => :environment do
    UserRole.create(:title => "user", :description => "Regular User")
    UserRole.create(:title => "admin", :description => "Admin User")
  end
  
   desc "Add users"
   task :default_users => :environment do
 
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
    u.supplied_password = 'admin_pass'
    u.avatar = File.open("public/users/avatars/he.jpg")
    u.save

    u = User.new
    u.first_name = "Danielle"
    u.last_name = "Griffiths"
    u.username = "griffd"
    u.screen_name = "Dan G"
    u.email = "danielle.griffiths@ngfl-cymru.org.uk"
    u.title = "Development Team Coordinator"
    u.description = ""
    u.level = 2
    u.active = true
    u.supplied_password = 'admin_pass'
    u.avatar = File.open("public/users/avatars/dg.jpg")
    u.save

    u = User.new
    u.first_name = "Hywel"
    u.last_name = "Jones"
    u.username = "joneshy"
    u.screen_name = "Hywel J"
    u.email = "hywel.jones@ngfl-cymru.org.uk"
    u.title = "Development Team Coordinator"
    u.description = ""
    u.level = 2
    u.active = true
    u.supplied_password = 'admin_pass'
    u.avatar = File.open("public/users/avatars/hyj.jpg")
    u.save

    u = User.new
    u.first_name = "Melanie"
    u.last_name = "Blount"
    u.username = "blountm"
    u.screen_name = "Mel B"
    u.email = "melanie.blount@wjec.co.uk"
    u.title = "Digital Team Co-ordinator"
    u.description = ""
    u.level = 2
    u.active = true
    u.supplied_password = 'admin_pass'
    u.avatar = File.open("public/users/avatars/mb.jpg")
    u.save

    u = User.new
    u.first_name = "Mike"
    u.last_name = "Ebbsworth"
    u.username = "ebbsworthm"
    u.screen_name = "Mike E"
    u.email = "mike.ebbsworth@cbac.co.uk"
    u.title = "Assistant Director, Educational Support"
    u.description = ""
    u.level = 2
    u.active = true
    u.supplied_password = 'admin_pass'
    u.avatar = File.open("public/users/avatars/me.jpg")
    u.save

    u = User.new
    u.first_name = "Dafydd"
    u.last_name = "Watcyn Williams"
    u.username = "williamsd"
    u.screen_name = "Dafydd WW"
    u.email = "dafydd.williams@cbac.co.uk"
    u.title = "Assistant Director, Educational Support"
    u.description = ""
    u.level = 2
    u.active = true
    u.supplied_password = 'admin_pass'
    u.avatar = File.open("public/users/avatars/dww.jpg")
    u.save

    u = User.new
    u.first_name = "Natalie"
    u.last_name = "White"
    u.username = "whiten"
    u.screen_name = "Natalie W"
    u.email = "natalie.white@ngfl-cymru.org.uk"
    u.title = "Developer"
    u.description = ""
    u.level = 1
    u.active = true
    u.supplied_password = 'so1234'
    u.avatar = File.open("public/users/avatars/nw.jpg")
    u.save

    u = User.new
    u.first_name = "Osian"
    u.last_name = "Hughes Jones"
    u.username = "jonesoh"
    u.screen_name = "Osian J"
    u.email = "osian.jones@ngfl-cymru.org.uk"
    u.title = "Developer"
    u.description = ""
    u.level = 1
    u.active = true
    u.supplied_password = 'so1234'
    u.avatar = File.open("public/users/avatars/oj.jpg")
    u.save

    u = User.new
    u.first_name = "Christopher"
    u.last_name = "Thomas"
    u.username = "thomasc"
    u.screen_name = "Chris T"
    u.email = "christopher.thomas@ngfl-cymru.org.uk"
    u.title = "Developer"
    u.description = ""
    u.level = 1
    u.active = true
    u.supplied_password = 'so1234'
    u.avatar = File.open("public/users/avatars/ct.jpg")
    u.save

    u = User.new
    u.first_name = "Rhys"
    u.last_name = "Morris"
    u.username = "morrisr"
    u.screen_name = "Rhys M"
    u.email = "rhys.morris@wjec.co.uk"
    u.title = "Developer"
    u.description = ""
    u.level = 1
    u.active = true
    u.supplied_password = 'so1234'
    u.avatar = File.open("public/users/avatars/rm.jpg")
    u.save

    u = User.new
    u.first_name = "Huw"
    u.last_name = "Jones"
    u.username = "joneshu"
    u.screen_name = "Huw J"
    u.email = "huw.jones@wjec.co.uk"
    u.title = "Developer"
    u.description = ""
    u.level = 1
    u.active = true
    u.supplied_password = 'so1234'
    u.avatar = File.open("public/users/avatars/hj.jpg")
    u.save

    
    
  end


  
  
  desc "Add 5 Test Projects"
  task :add_test_projects => :environment do
    
    p = Project.new
    p.name = "Alice in Wonderland"
    p.description = "Just then her head struck against the roof of the hall: in fact she was now more than nine feet high, and she at once took up the little golden key and hurried off to the garden door.Poor Alice! It was as much as she could do, lying down on one side, to look through into the garden with one eye; but to get through was more hopeless than ever: she sat down and began to cry again."
    p.deadline = 30.days.from_now
    p.code = "ALICE"
    p.project_type_id = 1
    p.users = [User.find_by_id(2), User.find_by_id(4)] 
    p.save
    
    p.tasks << Task.new(:deadline => p.deadline, :description => 'Description for the white rabbit task', :name => 'Follow the White Rabbit', :project_id => p.id, :user_id => User.find_by_username('evansh').id )
    p.tasks << Task.new(:deadline => p.deadline, :description => 'Description for the tea party task', :name => 'Attend the Mad Hatter\'s Tea Party', :project_id => p.id, :user_id => User.find_by_username('evansh').id )
    p.tasks << Task.new(:deadline => p.deadline, :description => 'Don\'t bump your head', :name => 'Eat Me Drink Me', :project_id => p.id, :user_id => User.find_by_username('legendary').id) 
    p.save
    
    
    p = Project.new
    p.name = "A Princess of Mars"
    p.description = "A second and third door receded before me and slipped to one side as the first, before I reached a large inner chamber where I found food and drink set out upon a great stone table. A voice directed me to satisfy my hunger and to feed my calot, and while I was thus engaged my invisible host put me through a severe and searching cross-examination."
    p.deadline = DateTime.civil(2012, 8, 12)
    p.code = "Mars"
    p.project_type_id = 2
    p.users = [User.find_by_id(1), User.find_by_id(2)]
    p.save
    
    
    p = Project.new
    p.name = "The Wizard of Oz"
    p.description = "\"That's all right,\" said the Scarecrow. \"You are quite welcome to take my head off, as long as it will be a better one when you put it on again.\""
    p.deadline = DateTime.civil(2012, 8, 1)
    p.code = "OZ"
    p.project_type_id = 3
    p.users = [User.find_by_id(5), User.find_by_id(3), User.find_by_id(6)]
    p.save
    
    
    p = Project.new
    p.name = "Moby Dick"
    p.description = "During the most violent shocks of the Typhoon, the man at the Pequod\'s jaw-bone tiller had several times been reelingly hurled to the deck by its spasmodic motions, even though preventer tackles had been attached to it - for they were slack - because some play to the tiller was indispensable."
    p.deadline = DateTime.civil(2012, 8, 17)
    p.code = "WHALE"
    p.project_type_id = 4
    p.users = [User.find_by_id(6), User.find_by_id(7)]
    p.save
    
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
  task :all => [:default_user_roles, :default_users, :add_project_types]
end