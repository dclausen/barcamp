desc "Seed Talk with dummy data"

namespace :seed do
  task :talks => :environment do

    puts "Destroying all rooms..."
    Room.destroy_all

    puts "Creating two rooms"
    Room.create(:name => "Braniff Room")
    Room.create(:name => "Worldcom Room")

    puts "Destroying all talks..."
    Talk.destroy_all

    first_names = %w(John Jill Stan Herbert Haley Robert)
    last_names = %w(Stepler Williamson Barth Luxor Yeats)
    times = (10..16).map { |x| [x,x,x+0.5,x+0.5] unless x == 12 }.reject { |x| x.nil? }.flatten
    titles = File.open('talks.csv','r').read.split("\n")
    room_a = Room.all.first
    room_b = Room.all[1]
    base_time = Time.local(Date.today.year,Date.today.month,Date.today.day,0,0)

    times.each_with_index do |time,idx|
      t = Talk.new(
        :day => Date.today,
        :name => titles.shift,
        :start_time => (base_time + time.hours).to_datetime,
        :end_time => (base_time + (time+0.5).hours).to_datetime,
        :who => "#{first_names[rand(first_names.size)]} #{last_names[rand(last_names.size)]}",
        :room => (idx % 2 == 0 ? room_a : room_b)
      )
      t.save!
      ap t

      break if idx == 7
    end

    puts "Created #{Talk.count} talks"

  end
end
