puts "Create movies"
Movie.destroy_all

10.times do |n|
  Movie.create!(
    name: "Movie Title #{n+1}",
    year: 2025,
    description: "sample #{n+1}",
    image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['movie']),
    is_showing: [true, false].sample,
  )
end
  puts "Movie created successfully"
