puts "Create movies and shedules"

ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 0")

Reservation.destroy_all
Schedule.destroy_all
Movie.destroy_all

ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 1")

# screen_ids = Screen.pluck(:id)

10.times do |n|
  Movie.create!(
    name: "Movie Title #{n+1}",
    year: 2025,
    description: "sample #{n+1}",
    image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['movie']),
    is_showing: [true, false].sample,
    # screen_id: screen_ids.sample
  )
end

Movie.all.each do |movie|
  rand(1..3).times do
    start_hour = rand(0..12)
    end_hour = rand(13..23)

    movie.schedules.create!(
      start_time: Time.new(2000, 1, 1, start_hour, 0, 0),
      end_time: Time.new(2000, 1, 1, end_hour, 0, 0)
    )
  end
end

  puts "Movie and schedules created successfully"
