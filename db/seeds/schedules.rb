puts "Create schedules"
Schedule.destroy_all

current_date = Date.today

10.times do |n|
  start_time = current_date + rand(0..6).days + rand(10..22).hours
  end_time = start_time + 2.hours

  Schedule.create(
    movie_id: n,
    start_time: start_time,
    end_time: end_time
  )
end
puts "Scedule created successfully"
