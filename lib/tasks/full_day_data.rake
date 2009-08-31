require 'environment'

desc "Create test data for full data using real topics"
task :create_test_data_full => [ "db:migrate" ] do
  
  Sponsor.delete_all
  Talk.delete_all
  Room.delete_all
    
  Sponsor.create( :name     => "Google",
                  :homepage => "http://google.com",
                  :level    => "Platinum",
                  :logo_url => "http://www.google.com/logos/olympics08_rowing.gif" )

  Sponsor.create( :name     => "RDM",
                  :homepage => "http://realdigitalmedia.com",
                  :level    => "gold",
                  :logo_url => "http://realdigitalmedia.com/images/logo_rdm2.jpg" )

  room_101 = Room.create( :name => "Room 101" )
  room_102 = Room.create( :name => "Room 102" )
  room_103 = Room.create( :name => "Room 103" )
  room_104 = Room.create( :name => "Room 104" )
  room_105 = Room.create( :name => "Room 105" )
  
  rooms = [room_105, room_104, room_103, room_102, room_101]
  speakers = ["Alan Turing","Charles Babbage","Grace Hopper",
              "Dennis Ritchie","Joe Armstrong","Ada Lovelace","Yukihiro Matsumoto"]
  
  #Use real topics from BarCamp London to create fake data. 
  titles = File.read('bc_london.txt').split("\n")  
  room = rooms.pop
  count_per_room = 0
  time = Time.at(14 * 60 * 60) #9AM EST == 14 UTC
  
  while titles.any?
    title = titles.pop
    t = Talk.create(:name => title, :start_time => time, :end_time => time + (30*60), 
                    :room => room, :who => speakers[rand(7)])
    t.save!
    count_per_room += 1  
    time += (30 * 60)
    
    if (count_per_room >= 18)
      count_per_room = 0
      room = rooms.pop
      time = Time.at(14 * 60 * 60)
    end
  end  

end
